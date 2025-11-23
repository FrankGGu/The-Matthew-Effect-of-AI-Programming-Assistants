#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

typedef struct AdjNode {
    int neighbor;
    int weight;
    struct AdjNode* next;
} AdjNode;

AdjNode** adj_global;
int N_nodes_global;
int SignalSpeed_global;

void dfs(int u, int parent, long long current_dist, int* current_subtree_counts) {
    current_subtree_counts[current_dist % SignalSpeed_global]++;

    AdjNode* node = adj_global[u];
    while (node != NULL) {
        int v = node->neighbor;
        int w = node->weight;
        if (v != parent) {
            dfs(v, u, current_dist + w, current_subtree_counts);
        }
        node = node->next;
    }
}

long long* countPairsOfConnectableServers(int** edges, int edgesSize, int* edgesColSize, int signalSpeed) {
    N_nodes_global = edgesSize + 1; // N nodes for N-1 edges in a tree
    SignalSpeed_global = signalSpeed;

    // Allocate adjacency list
    adj_global = (AdjNode**)malloc(N_nodes_global * sizeof(AdjNode*));
    for (int i = 0; i < N_nodes_global; ++i) {
        adj_global[i] = NULL;
    }

    // Build adjacency list
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        AdjNode* newNode1 = (AdjNode*)malloc(sizeof(AdjNode));
        newNode1->neighbor = v;
        newNode1->weight = w;
        newNode1->next = adj_global[u];
        adj_global[u] = newNode1;

        AdjNode* newNode2 = (AdjNode*)malloc(sizeof(AdjNode));
        newNode2->neighbor = u;
        newNode2->weight = w;
        newNode2->next = adj_global[v];
        adj_global[v] = newNode2;
    }

    long long* ans = (long long*)malloc(N_nodes_global * sizeof(long long));

    // For each node i, consider it as the meeting point (LCA) for paths (u,v)
    for (int i = 0; i < N_nodes_global; ++i) {
        ans[i] = 0;
        // path_counts_from_i_to_children_subtrees stores counts of (distance % signalSpeed)
        // for nodes in subtrees rooted at neighbors of i that have already been processed.
        int* path_counts_from_i_to_children_subtrees = (int*)calloc(SignalSpeed_global, sizeof(int));

        // Iterate through neighbors of i
        AdjNode* node = adj_global[i];
        while (node != NULL) {
            int v = node->neighbor;
            int w = node->weight;

            // current_subtree_counts stores counts of (distance % signalSpeed)
            // for nodes in the current subtree rooted at v (when i is its parent).
            int* current_subtree_counts = (int*)calloc(SignalSpeed_global, sizeof(int));

            // Perform DFS from neighbor v, treating i as its parent.
            // The initial distance from i to v is w.
            dfs(v, i, (long long)w, current_subtree_counts); 

            // Combine counts: find pairs (x, y) where x is in a previously processed subtree
            // and y is in the current subtree rooted at v, such that dist(x,i) + dist(i,y) is divisible by signalSpeed.
            // This means (dist(x,i) % S + dist(i,y) % S) % S == 0.
            for (int r1 = 0; r1 < SignalSpeed_global; ++r1) {
                if (path_counts_from_i_to_children_subtrees[r1] > 0) {
                    int r2 = (SignalSpeed_global - r1) % SignalSpeed_global;
                    ans[i] += (long long)path_counts_from_i_to_children_subtrees[r1] * current_subtree_counts[r2];
                }
            }

            // Update path_counts_from_i_to_children_subtrees by adding counts from the current subtree
            // so they can be combined with future subtrees.
            for (int r = 0; r < SignalSpeed_global; ++r) {
                path_counts_from_i_to_children_subtrees[r] += current_subtree_counts[r];
            }

            free(current_subtree_counts);
            node = node->next;
        }
        free(path_counts_from_i_to_children_subtrees);
    }

    // Free adjacency list memory
    for (int i = 0; i < N_nodes_global; ++i) {
        AdjNode* current = adj_global[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj_global);

    return ans;
}