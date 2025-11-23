#include <stdlib.h>
#include <string.h> // For memset, if needed, but calloc initializes to 0

void dfs(int u, int* edges, int n, int* ans, int* visited_state, int* path_nodes, int* path_indices, int* current_path_len_ptr) {
    visited_state[u] = 1; // Mark as visiting (in current DFS path)
    path_nodes[*current_path_len_ptr] = u;
    path_indices[u] = *current_path_len_ptr; // Store index of u in current path
    (*current_path_len_ptr)++;

    int v = edges[u];

    if (visited_state[v] == 2) { // Node v already processed, its answer is known
        ans[u] = 1 + ans[v];
    } else if (visited_state[v] == 1) { // Cycle detected: v is in the current DFS path
        int cycle_start_idx = path_indices[v];
        int cycle_length = (*current_path_len_ptr) - cycle_start_idx;

        // Assign cycle length to all nodes in the cycle
        for (int i = cycle_start_idx; i < (*current_path_len_ptr); i++) {
            ans[path_nodes[i]] = cycle_length;
        }
    } else { // v not visited yet, recurse
        dfs(v, edges, n, ans, visited_state, path_nodes, path_indices, current_path_len_ptr);

        // After recursion returns, ans[v] is known.
        // If ans[u] is still 0, it means u was not part of a cycle detected in this path.
        // It must be a node leading into an already calculated path or a cycle.
        if (ans[u] == 0) { 
            ans[u] = 1 + ans[v];
        }
    }

    visited_state[u] = 2; // Mark as finished (answer computed)
    (*current_path_len_ptr)--; // Pop u from current path
}

int* countVisitedNodes(int* edges, int edgesSize, int* returnSize) {
    int n = edgesSize;
    *returnSize = n;

    int* ans = (int*)malloc(n * sizeof(int));
    // visited_state: 0 = unvisited, 1 = visiting (in current DFS path), 2 = visited (answer computed)
    int* visited_state = (int*)calloc(n, sizeof(int)); // Initialize to 0

    // path_nodes: stores nodes in the current DFS path
    int* path_nodes = (int*)malloc(n * sizeof(int));
    // path_indices: stores index of a node in path_nodes for current DFS path
    // path_indices[node_id] = index_in_path_nodes
    // This array only needs to be valid for nodes currently in the path_nodes array.
    int* path_indices = (int*)malloc(n * sizeof(int));

    int current_path_len = 0; // Length of the current DFS path

    for (int i = 0; i < n; i++) {
        if (visited_state[i] == 0) { // If node i hasn't been visited yet
            current_path_len = 0; // Reset path length for a new DFS traversal
            dfs(i, edges, n, ans, visited_state, path_nodes, path_indices, &current_path_len);
        }
    }

    free(visited_state);
    free(path_nodes);
    free(path_indices);

    return ans;
}