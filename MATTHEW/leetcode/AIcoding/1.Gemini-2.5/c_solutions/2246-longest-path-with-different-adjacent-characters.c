#include <stdlib.h> // For malloc, realloc, free, calloc

int max(int a, int b) {
    return a > b ? a : b;
}

typedef struct {
    int* neighbors;
    int count;
    int capacity;
} AdjList;

void add_edge(AdjList* adj, int u, int v) {
    if (adj[u].count == adj[u].capacity) {
        adj[u].capacity = adj[u].capacity == 0 ? 4 : adj[u].capacity * 2;
        adj[u].neighbors = (int*)realloc(adj[u].neighbors, sizeof(int) * adj[u].capacity);
    }
    adj[u].neighbors[adj[u].count++] = v;
}

int dfs(int u, int parent, AdjList* adj, char* s, int* global_max_path) {
    int long_path1 = 0; // Length of the longest valid path from a child of 'u' downwards
    int long_path2 = 0; // Length of the second longest valid path from a child of 'u' downwards

    for (int i = 0; i < adj[u].count; i++) {
        int v = adj[u].neighbors[i];
        if (v == parent) {
            continue;
        }

        // Recursively get the longest path from child 'v' downwards
        int child_path_len = dfs(v, u, adj, s, global_max_path);

        // If characters are different, we can extend the path from 'u' to 'v'
        if (s[u] != s[v]) {
            if (child_path_len > long_path1) {
                long_path2 = long_path1;
                long_path1 = child_path_len;
            } else if (child_path_len > long_path2) {
                long_path2 = child_path_len;
            }
        }
    }

    // Update the global maximum path. This path can go through 'u' and extend into two different subtrees.
    // The length is 1 (for 'u') + long_path1 + long_path2.
    *global_max_path = max(*global_max_path, 1 + long_path1 + long_path2);

    // Return the longest path that starts at 'u' and goes downwards into one subtree.
    // This path is 1 (for 'u') + long_path1. This value is used by 'u's parent.
    return 1 + long_path1;
}

int longestPath(int* parent, int parentSize, char* s) {
    int n = parentSize;
    // According to constraints, n >= 1, so n=0 case is not strictly necessary.
    // if (n == 0) {
    //     return 0;
    // }

    // Allocate and initialize adjacency list for 'n' nodes
    AdjList* adj = (AdjList*)calloc(n, sizeof(AdjList));

    // Build the adjacency list. The input 'parent' array describes edges from i to parent[i].
    // Since it's a tree, we add bidirectional edges.
    // Node 0 is the root and has parent[0] = -1, so loop starts from 1.
    for (int i = 1; i < n; i++) {
        add_edge(adj, parent[i], i);
        add_edge(adj, i, parent[i]);
    }

    // Initialize global maximum path length to 1 (a single node path is always valid)
    int global_max_path = 1;

    // Start DFS from the root (node 0)
    dfs(0, -1, adj, s, &global_max_path);

    // Free allocated memory for adjacency list
    for (int i = 0; i < n; i++) {
        free(adj[i].neighbors); // Free neighbors array for each node
    }
    free(adj); // Free the array of AdjList structures

    return global_max_path;
}