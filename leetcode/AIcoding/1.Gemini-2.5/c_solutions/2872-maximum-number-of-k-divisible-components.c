#include <stdlib.h> // For malloc, free (though not directly used for dynamic allocation here, might be needed for other contexts)
#include <string.h> // For memset

#define MAX_N 100005

int adj_list_heads[MAX_N];
int adj_list_next[2 * (MAX_N - 1)];
int adj_list_nodes[2 * (MAX_N - 1)];
int edge_count_global;

int global_component_count;

long long dfs(int u, int parent, int k, int* values) {
    // Initialize the current subtree sum with the value of the current node.
    long long current_subtree_sum = values[u];

    // Iterate through all neighbors of the current node u.
    for (int i = adj_list_heads[u]; i != -1; i = adj_list_next[i]) {
        int v = adj_list_nodes[i];
        // Skip the parent node to avoid infinite loops in an undirected graph.
        if (v == parent) {
            continue;
        }
        // Recursively call DFS for the child node and add its returned sum to the current subtree sum.
        current_subtree_sum += dfs(v, u, k, values);
    }

    // After visiting all children, check if the total sum of this subtree (including u and
    // sums from children that didn't form components) is divisible by k.
    if (current_subtree_sum % k == 0) {
        // If it is divisible, this subtree forms a k-divisible component.
        // Increment the global count of such components.
        global_component_count++;
        // Return 0, indicating that this component is "cut" and contributes nothing to its parent.
        return 0;
    } else {
        // If not divisible, this subtree cannot form a k-divisible component on its own.
        // Its sum must be passed up to its parent to potentially form a larger component.
        return current_subtree_sum;
    }
}

int maxKDivisibleComponents(int n, int** edges, int edgesSize, int* edgesColSize, int* values, int valuesSize, int k) {
    // Initialize adjacency list heads to -1 to signify no edges yet.
    // Using memset for global static arrays is safe and efficient for re-initialization.
    memset(adj_list_heads, -1, sizeof(int) * n);
    // Reset the global edge counter for building the adjacency list for each test case.
    edge_count_global = 0;

    // Build the adjacency list for the undirected tree.
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        // Add edge u -> v
        adj_list_nodes[edge_count_global] = v;
        adj_list_next[edge_count_global] = adj_list_heads[u];
        adj_list_heads[u] = edge_count_global;
        edge_count_global++;

        // Add edge v -> u (since the graph is undirected)
        adj_list_nodes[edge_count_global] = u;
        adj_list_next[edge_count_global] = adj_list_heads[v];
        adj_list_heads[v] = edge_count_global;
        edge_count_global++;
    }

    // Reset the global component count for each test case.
    global_component_count = 0;

    // Start the DFS traversal from node 0 (arbitrary root for a tree).
    // The parent of the root is typically represented by -1.
    // The return value of this initial call is not directly used for the final answer,
    // as the global_component_count accumulates the result.
    dfs(0, -1, k, values);

    // Return the total number of k-divisible components found.
    return global_component_count;
}