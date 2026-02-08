#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

#define MAXN 10001    // Max number of nodes + 1 (for 1-indexed nodes)
#define MAX_WEIGHT 26 // Max edge weight
#define LOGN 14       // ceil(log2(MAXN)) for binary lifting (2^13 = 8192, 2^14 = 16384)

int head[MAXN];
int to[MAXN * 2];
int weight[MAXN * 2];
int next_edge[MAXN * 2];
int edge_count;

int depth[MAXN];
int parent[MAXN][LOGN];
int freq[MAXN][MAX_WEIGHT + 1]; // freq[node][weight] stores count of edges with 'weight' from root to 'node'

void add_edge(int u, int v, int w) {
    to[edge_count] = v;
    weight[edge_count] = w;
    next_edge[edge_count] = head[u];
    head[u] = edge_count++;
}

void dfs(int u, int p, int d, int edge_w_to_u) {
    depth[u] = d;
    parent[u][0] = p;

    // Copy frequencies from parent node
    if (p != 0) { // If not the dummy root (node 0)
        for (int k = 1; k <= MAX_WEIGHT; k++) {
            freq[u][k] = freq[p][k];
        }
        // Increment frequency for the edge connecting p to u
        freq[u][edge_w_to_u]++;
    } else { // Root node (u=1, p=0), frequencies are all 0
        for (int k = 1; k <= MAX_WEIGHT; k++) {
            freq[u][k] = 0;
        }
    }

    // Recurse for children
    for (int i = head[u]; i != -1; i = next_edge[i]) {
        int v = to[i];
        int w = weight[i];
        if (v == p) continue; // Avoid going back to parent
        dfs(v, u, d + 1, w);
    }
}

void precompute_lca(int n) {
    for (int k = 1; k < LOGN; k++) {
        for (int i = 1; i <= n; i++) {
            // parent[i][k] is the 2^k-th ancestor of i
            // which is the 2^(k-1)-th ancestor of the 2^(k-1)-th ancestor of i
            if (parent[i][k - 1] != 0) { // Check if 2^(k-1)-th ancestor exists (not dummy root)
                parent[i][k] = parent[parent[i][k - 1]][k - 1];
            } else {
                parent[i][k] = 0; // If ancestor is dummy root, all higher ancestors are also dummy root
            }
        }
    }
}

int get_lca(int u, int v) {
    // Ensure u is deeper or at the same depth as v
    if (depth[u] < depth[v]) {
        int temp = u;
        u = v;
        v = temp;
    }

    // Lift u to the same depth as v
    for (int k = LOGN - 1; k >= 0; k--) {
        if (parent[u][k] != 0 && depth[parent[u][k]] >= depth[v]) {
            u = parent[u][k];
        }
    }

    // If u is now v, then v (or u) is the LCA
    if (u == v) return u;

    // Lift u and v simultaneously until their parents are the same
    for (int k = LOGN - 1; k >= 0; k--) {
        if (parent[u][k] != 0 && parent[v][k] != 0 && parent[u][k] != parent[v][k]) {
            u = parent[u][k];
            v = parent[v][k];
        }
    }
    // The parent of u (or v) is the LCA
    return parent[u][0];
}

int* minEdgeWeightQueries(int n, int** edges, int edgesSize, int* edgesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Initialize global variables for a new test case
    edge_count = 0;
    for (int i = 0; i <= n; i++) {
        head[i] = -1; // Initialize adjacency list heads
        depth[i] = 0;
        for (int k = 0; k < LOGN; k++) {
            parent[i][k] = 0; // Node 0 is a dummy root/sentinel
        }
        for (int k = 0; k <= MAX_WEIGHT; k++) {
            freq[i][k] = 0;
        }
    }

    // Build the adjacency list for the tree
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        add_edge(u, v, w);
        add_edge(v, u, w); // Tree is undirected
    }

    // Perform DFS starting from node 1 (assuming 1-indexed nodes, 0 is dummy parent)
    // Root (node 1) has depth 0, its parent is 0, and no incoming edge weight from parent 0
    dfs(1, 0, 0, 0);

    // Precompute ancestors for LCA using binary lifting
    precompute_lca(n);

    // Allocate memory for the results
    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));
    if (result == NULL) {
        // Handle malloc failure if necessary
        return NULL;
    }

    // Process each query
    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];

        int lca = get_lca(u, v);

        // Calculate total number of edges on the path from u to v
        // path_len = (edges from root to u) + (edges from root to v) - 2 * (edges from root to lca)
        int path_len = depth[u] + depth[v] - 2 * depth[lca];

        // Initialize minimum changes to the maximum possible (change all edges)
        int min_changes = path_len;

        // Iterate through all possible target edge weights (1 to 26)
        for (int w = 1; w <= MAX_WEIGHT; w++) {
            // Calculate count of edges with weight 'w' on the path from u to v
            // count_w = (freq[u][w] from root to u) + (freq[v][w] from root to v) - 2 * (freq[lca][w] from root to lca)
            int count_w = freq[u][w] + freq[v][w] - 2 * freq[lca][w];

            // Number of changes needed if all edges on path u-v should have weight 'w'
            int changes = path_len - count_w;

            // Update minimum changes
            if (changes < min_changes) {
                min_changes = changes;
            }
        }
        result[i] = min_changes;
    }

    return result;
}