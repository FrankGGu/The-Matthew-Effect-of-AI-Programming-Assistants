#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

#define MAX_NODES 100005 
#define MAX_EDGES (2 * (MAX_NODES - 1)) // Max edges in an undirected graph forming a forest (2 * (N-1) entries in adjacency list)

int adj_head[MAX_NODES];       // Stores the index of the first edge for each node
int adj_next_edge[MAX_EDGES];  // Stores the index of the next edge in the list
int adj_to_node[MAX_EDGES];    // Stores the destination node for each edge
int edge_count;                // Tracks the current number of edges added to the adj list

bool visited[MAX_NODES];       // Tracks visited nodes during DFS
bool is_target_node[MAX_NODES]; // Flags if a node is a target node

void add_edge(int u, int v) {
    // Add v to u's adjacency list
    adj_to_node[edge_count] = v;
    adj_next_edge[edge_count] = adj_head[u];
    adj_head[u] = edge_count++;

    // Add u to v's adjacency list (for undirected graph)
    adj_to_node[edge_count] = u;
    adj_next_edge[edge_count] = adj_head[v];
    adj_head[v] = edge_count++;
}

int dfs(int u) {
    visited[u] = true; // Mark current node as visited
    int current_component_targets = is_target_node[u] ? 1 : 0; // Count if current node is a target

    // Iterate through all neighbors of u
    for (int edge_idx = adj_head[u]; edge_idx != -1; edge_idx = adj_next_edge[edge_idx]) {
        int v = adj_to_node[edge_idx];
        if (!visited[v]) { // If neighbor v has not been visited, recursively call DFS
            current_component_targets += dfs(v);
        }
    }
    return current_component_targets; // Return total target nodes in this component
}

int compare_ints_desc(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int maximizeTheNumberOfTargetNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* target, int targetSize, int k) {
    // 1. Initialize adjacency list structures and target node flags
    // Reset adjacency list heads to -1 (indicating no edges for any node)
    memset(adj_head, -1, sizeof(int) * n);
    edge_count = 0; // Reset edge counter for adjacency list construction

    // Reset target node flags and mark actual target nodes based on input
    memset(is_target_node, false, sizeof(bool) * n);
    for (int i = 0; i < targetSize; ++i) {
        is_target_node[target[i]] = true;
    }

    // Build the adjacency list from the given edges
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v);
    }

    // 2. Find connected components and count target nodes in each
    // Reset visited array for DFS for the current test case
    memset(visited, false, sizeof(bool) * n);

    // Allocate memory for storing target counts of each component.
    // In the worst case, each node is its own component, so N components.
    int* component_target_counts = (int*) malloc(sizeof(int) * n);
    int num_components_found = 0; // Counter for components found

    for (int i = 0; i < n; ++i) {
        if (!visited[i]) { // If node i has not been visited, it's part of a new connected component
            int targets_in_comp = dfs(i);
            // Only consider components that contain at least one target node.
            // Components without target nodes do not contribute positively to the total,
            // and using an edge to connect them would be suboptimal if other target-containing components exist.
            if (targets_in_comp > 0) {
                component_target_counts[num_components_found++] = targets_in_comp;
            }
        }
    }

    // 3. Sort the component target counts in descending order
    qsort(component_target_counts, num_components_found, sizeof(int), compare_ints_desc);

    // 4. Sum the top `min(k+1, num_components_found)` counts
    // We can connect at most k+1 components using k new edges to form one large component.
    int max_target_nodes = 0;
    int components_to_take = k + 1; 

    // Determine how many components to actually sum (limited by the number of available components with targets)
    int num_to_sum = (num_components_found < components_to_take) ? num_components_found : components_to_take;

    for (int i = 0; i < num_to_sum; ++i) {
        max_target_nodes += component_target_counts[i];
    }

    // Free dynamically allocated memory
    free(component_target_counts);

    return max_target_nodes;
}