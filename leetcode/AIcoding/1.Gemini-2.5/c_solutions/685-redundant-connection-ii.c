#include <stdlib.h>
#include <stdbool.h>

int find(int* parent, int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

bool unite(int* parent, int i, int j) {
    int rootI = find(parent, i);
    int rootJ = find(parent, j);
    if (rootI != rootJ) {
        parent[rootJ] = rootI; // Simple union
        return true;
    }
    return false; // Cycle detected
}

int* findRedundantDirectedConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = edgesSize; // N nodes labeled 1 to N

    // parent_map[i] stores the immediate parent of node i in the graph being built.
    // Used to detect nodes with in-degree 2.
    int* parent_map = (int*)calloc(n + 1, sizeof(int));

    // in_degree[i] stores the current in-degree of node i.
    int* in_degree = (int*)calloc(n + 1, sizeof(int));

    // Pointers to store the two edges that cause a node to have in-degree 2.
    int* edge1_double_parent = NULL; // The first edge (u, v) pointing to v
    int* edge2_double_parent = NULL; // The second (later) edge (u, v) pointing to v

    // First pass: Identify if any node has two parents.
    // If found, store the two edges involved.
    for (int i = 0; i < n; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        in_degree[v]++;
        if (in_degree[v] == 2) {
            // Node 'v' now has two parents.
            // The first parent was parent_map[v]. The edge was (parent_map[v], v).
            // The second parent is 'u'. The edge is (u, v), which is edges[i].
            edge1_double_parent = (int*)malloc(2 * sizeof(int));
            edge1_double_parent[0] = parent_map[v];
            edge1_double_parent[1] = v;

            edge2_double_parent = edges[i]; // This is the current edge being processed
            break; // We've found the problematic node and its two incoming edges.
        }
        parent_map[v] = u; // Store the current parent for 'v'
    }

    // Case 1: A node has two parents.
    if (edge2_double_parent != NULL) {
        // We have two candidate edges: edge1_double_parent and edge2_double_parent.
        // According to the problem, if multiple answers, return the one that appears last.
        // So, we first try removing edge2_double_parent (the later one).
        // If removing edge2_double_parent makes the graph a valid tree (no cycle), then it's the answer.
        // Otherwise, edge1_double_parent must be the one that forms a cycle, so it's the answer.

        int* dsu_parent = (int*)malloc((n + 1) * sizeof(int));
        for (int i = 1; i <= n; i++) {
            dsu_parent[i] = i; // Initialize DSU sets
        }

        bool cycle_after_removing_e2 = false;
        for (int i = 0; i < n; i++) {
            int u = edges[i][0];
            int v = edges[i][1];

            // Skip edge2_double_parent
            if (u == edge2_double_parent[0] && v == edge2_double_parent[1]) {
                continue;
            }

            if (!unite(dsu_parent, u, v)) {
                cycle_after_removing_e2 = true;
                break; // Cycle detected even after removing edge2_double_parent
            }
        }
        free(dsu_parent); // Free DSU parent array

        if (cycle_after_removing_e2) {
            // Removing edge2_double_parent still leaves a cycle.
            // This implies that edge1_double_parent must be the edge that completes the cycle.
            // So, edge1_double_parent is the redundant connection.
            *returnSize = 2;
            free(in_degree);
            free(parent_map);
            return edge1_double_parent;
        } else {
            // Removing edge2_double_parent resolved the issue (no cycle, and the in-degree is now 1 for v).
            // So, edge2_double_parent is the redundant connection.
            *returnSize = 2;
            free(in_degree);
            free(parent_map);
            free(edge1_double_parent); // Free the dynamically allocated edge we're not returning
            return edge2_double_parent;
        }
    }

    // Case 2: No node has two parents.
    // This means the redundant edge solely forms a cycle.
    // We use DSU to find the edge that forms this cycle.
    int* dsu_parent = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 1; i <= n; i++) {
        dsu_parent[i] = i; // Initialize DSU sets
    }

    int* cycle_edge = NULL;
    for (int i = 0; i < n; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (!unite(dsu_parent, u, v)) {
            // This edge forms a cycle. It's the redundant connection.
            cycle_edge = edges[i];
            break;
        }
    }
    free(dsu_parent); // Free DSU parent array

    *returnSize = 2;
    free(in_degree);
    free(parent_map);
    return cycle_edge;
}