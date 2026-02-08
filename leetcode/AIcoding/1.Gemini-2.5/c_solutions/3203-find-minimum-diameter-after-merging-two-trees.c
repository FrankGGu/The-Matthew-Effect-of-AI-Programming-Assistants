#include <stdlib.h>
#include <string.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int bfs(int start_node, int n, int** adj, int* adj_sizes, int* dist_array) {
    for (int i = 0; i < n; i++) {
        dist_array[i] = -1; // -1 means unvisited
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;

    queue[tail++] = start_node;
    dist_array[start_node] = 0;

    int farthest_node = start_node;
    int max_dist = 0;

    while (head < tail) {
        int u = queue[head++];

        if (dist_array[u] >= max_dist) {
            max_dist = dist_array[u];
            farthest_node = u;
        }

        for (int i = 0; i < adj_sizes[u]; i++) {
            int v = adj[u][i];
            if (dist_array[v] == -1) {
                dist_array[v] = dist_array[u] + 1;
                queue[tail++] = v;
            }
        }
    }
    free(queue);
    return farthest_node;
}

int* get_tree_info(int n, int** edges, int edges_size, int* edges_col_size) {
    int* result = (int*)malloc(2 * sizeof(int));
    if (n <= 1) { // Handles n=0 and n=1 cases
        result[0] = 0; // diameter
        result[1] = 0; // radius
        return result;
    }

    // Build adjacency list
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adj_sizes = (int*)calloc(n, sizeof(int));

    // First pass to count degrees for allocation
    for (int i = 0; i < edges_size; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj_sizes[u]++;
        adj_sizes[v]++;
    }

    // Allocate memory for each adjacency list and reset sizes for filling
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(adj_sizes[i] * sizeof(int));
        adj_sizes[i] = 0; // Reset sizes for filling
    }

    // Second pass to fill adjacency lists
    for (int i = 0; i < edges_size; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_sizes[u]++] = v;
        adj[v][adj_sizes[v]++] = u;
    }

    // --- Calculate Diameter and Radius ---
    int* dist_from_x = (int*)malloc(n * sizeof(int));
    int* dist_from_y = (int*)malloc(n * sizeof(int));

    // 1. Find a farthest node 'x' from an arbitrary node (e.g., node 0)
    int x = bfs(0, n, adj, adj_sizes, dist_from_x);

    // 2. Find a farthest node 'y' from 'x'. The distance dist_from_y[y] is the diameter.
    int y = bfs(x, n, adj, adj_sizes, dist_from_y);
    result[0] = dist_from_y[y]; // Diameter

    // 3. Calculate radius: min(max(dist_from_x[i], dist_from_y[i])) for all i
    int radius = INT_MAX;
    for (int i = 0; i < n; i++) {
        radius = min(radius, max(dist_from_x[i], dist_from_y[i]));
    }
    result[1] = radius;

    // Clean up
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adj_sizes);
    free(dist_from_x);
    free(dist_from_y);

    return result;
}

int findMinimumDiameterAfterMergingTwoTrees(int n1, int** edges1, int edges1Size, int* edges1ColSize,
                                            int n2, int** edges2, int edges2Size, int* edges2ColSize) {

    int* info1 = get_tree_info(n1, edges1, edges1Size, edges1ColSize);
    int d1 = info1[0];
    int r1 = info1[1];
    free(info1);

    int* info2 = get_tree_info(n2, edges2, edges2Size, edges2ColSize);
    int d2 = info2[0];
    int r2 = info2[1];
    free(info2);

    // The new diameter can be one of three types:
    // 1. The diameter of tree1 itself.
    // 2. The diameter of tree2 itself.
    // 3. A path going through the new edge. To minimize this, we connect the centers
    //    of the two trees. The length would be radius1 + 1 (for the new edge) + radius2.
    int merged_diameter = max(d1, d2);
    merged_diameter = max(merged_diameter, r1 + r2 + 1);

    return merged_diameter;
}