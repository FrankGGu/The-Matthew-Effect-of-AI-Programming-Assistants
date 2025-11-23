#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memset

#define MAX_COLORS 61

bool isPrintable(int** targetGrid, int targetGridSize, int* targetGridColSize) {
    int m = targetGridSize;
    int n = targetGridColSize[0];

    int min_r[MAX_COLORS];
    int max_r[MAX_COLORS];
    int min_c[MAX_COLORS];
    int max_c[MAX_COLORS];
    bool found_color[MAX_COLORS];

    // Initialize bounding boxes and found_color status
    for (int i = 0; i < MAX_COLORS; ++i) {
        min_r[i] = m;
        max_r[i] = -1;
        min_c[i] = n;
        max_c[i] = -1;
        found_color[i] = false;
    }

    int total_unique_colors = 0;

    // Find bounding boxes for each color present in the grid
    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            int color = targetGrid[r][c];
            if (!found_color[color]) {
                found_color[color] = true;
                total_unique_colors++;
            }
            if (r < min_r[color]) min_r[color] = r;
            if (r > max_r[color]) max_r[color] = r;
            if (c < min_c[color]) min_c[color] = c;
            if (c > max_c[color]) max_c[color] = c;
        }
    }

    // Adjacency list and in-degree for the dependency graph
    // An edge u -> v means color u must be printed before color v.
    int adj[MAX_COLORS][MAX_COLORS]; // Stores neighbors for each color
    int adj_sizes[MAX_COLORS];       // Number of neighbors for each color
    int in_degree[MAX_COLORS];
    bool visited_edge[MAX_COLORS][MAX_COLORS]; // To prevent adding duplicate edges

    memset(adj_sizes, 0, sizeof(adj_sizes));
    memset(in_degree, 0, sizeof(in_degree));
    memset(visited_edge, false, sizeof(visited_edge));

    // Build the dependency graph
    for (int k = 1; k < MAX_COLORS; ++k) {
        if (!found_color[k]) {
            continue; // Skip colors not present in the grid
        }

        // Iterate through the bounding box of color k
        for (int r = min_r[k]; r <= max_r[k]; ++r) {
            for (int c = min_c[k]; c <= max_c[k]; ++c) {
                int current_cell_color = targetGrid[r][c];
                if (current_cell_color != k) {
                    // If a different color 'current_cell_color' is found within the bounding box of color k,
                    // it means 'current_cell_color' must have been printed *after* k to overwrite k at this cell.
                    // Therefore, k must be printed *before* 'current_cell_color'.
                    // Add dependency: k -> current_cell_color
                    if (!visited_edge[k][current_cell_color]) {
                        adj[k][adj_sizes[k]++] = current_cell_color;
                        in_degree[current_cell_color]++;
                        visited_edge[k][current_cell_color] = true;
                    }
                }
            }
        }
    }

    // Topological sort using Kahn's algorithm (BFS-based)
    int queue[MAX_COLORS];
    int front = 0, rear = 0;
    int printed_colors_count = 0;

    // Add all colors with in-degree 0 (no prerequisites) to the queue
    for (int k = 1; k < MAX_COLORS; ++k) {
        if (found_color[k] && in_degree[k] == 0) {
            queue[rear++] = k;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        printed_colors_count++;

        // For each color v that depends on u (i.e., u -> v)
        for (int i = 0; i < adj_sizes[u]; ++i) {
            int v = adj[u][i];
            in_degree[v]--;
            // If v now has no prerequisites, add it to the queue
            if (in_degree[v] == 0) {
                queue[rear++] = v;
            }
        }
    }

    // If all unique colors were successfully processed (i.e., a topological sort was possible),
    // then a valid printing order exists. Otherwise, a cycle was detected.
    return printed_colors_count == total_unique_colors;
}