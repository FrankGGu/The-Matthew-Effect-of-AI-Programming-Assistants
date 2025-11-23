#include <stdlib.h> // For malloc, free
#include <string.h> // For memset (optional, for explicit initialization)

int* adj_heads;
int* adj_nodes;
int* adj_next;
int edge_idx;
int global_k;
int global_ans;

void add_edge(int u, int v) {
    adj_nodes[edge_idx] = v;
    adj_next[edge_idx] = adj_heads[u];
    adj_heads[u] = edge_idx;
    edge_idx++;
}

long long dfs(int u, int p, int* values) {
    // Initialize current_sum with the value of the current node
    long long current_sum = values[u];

    // Iterate through neighbors of the current node
    for (int i = adj_heads[u]; i != -1; i = adj_next[i]) {
        int v = adj_nodes[i];
        // Skip the parent to avoid going back up the tree
        if (v == p) {
            continue;
        }
        // Recursively call DFS for children and add their returned sum to current_sum
        current_sum += dfs(v, u, values);
    }

    // If the current subtree's total sum is divisible by k
    if (current_sum % global_k == 0) {
        global_ans++; // Increment the count of k-divisible components
        return 0;     // This subtree forms a k-divisible component, so it contributes 0 to its parent's sum
    } else {
        // Otherwise, this subtree does not form a k-divisible component yet, pass its sum up to its parent
        return current_sum;
    }
}

int maxKDivisibleComponents(int n, int** edges, int edgesSize, int* edgesColSize, int* values, int valuesSize, int k) {
    // Initialize global variables
    global_k = k;
    global_ans = 0;

    // Allocate memory for adjacency list
    // adj_heads: stores the head of the adjacency list for each node
    adj_heads = (int*)malloc(n * sizeof(int));
    // adj_nodes: stores the destination node for each edge
    // adj_next: stores the index of the next edge in the adjacency list for a node
    // For an undirected graph with 'edgesSize' edges, we need 2 * edgesSize entries
    adj_nodes = (int*)malloc(2 * edgesSize * sizeof(int));
    adj_next = (int*)malloc(2 * edgesSize * sizeof(int));

    // Initialize adj_heads to -1 (indicating an empty list)
    for (int i = 0; i < n; i++) {
        adj_heads[i] = -1;
    }
    edge_idx = 0; // Reset edge index for building the adjacency list

    // Build the adjacency list from the given edges
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v); // Add edge u -> v
        add_edge(v, u); // Add edge v -> u (for undirected graph)
    }

    // Start DFS from node 0 (any node can be chosen as the root for a tree)
    // -1 is used as a dummy parent for the root node
    if (n > 0) { // Ensure n is positive before calling DFS
        dfs(0, -1, values);
    }

    // Free allocated memory to prevent memory leaks
    free(adj_heads);
    // Only free adj_nodes and adj_next if they were actually allocated with non-zero size
    if (edgesSize > 0) {
        free(adj_nodes);
        free(adj_next);
    }

    return global_ans;
}