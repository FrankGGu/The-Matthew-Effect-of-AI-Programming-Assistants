/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** constructGridLayout(int n, int* edges, int edgesSize, int* edgesColSize, int* returnSize, int** returnColumnSizes) {
    // Build adjacency list
    int** adj = (int**)malloc(n * sizeof(int*));
    int* deg = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(4 * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][deg[u]++] = v;
        adj[v][deg[v]++] = u;
    }

    // Find starting node (degree 2)
    int start = 0;
    for (int i = 0; i < n; i++) {
        if (deg[i] == 2) {
            start = i;
            break;
        }
    }

    // Determine grid dimensions
    int rows = 1, cols = 1;
    if (n == 1) {
        rows = cols = 1;
    } else {
        while (rows * cols < n) {
            if (rows == cols) cols++;
            else rows++;
        }
    }

    // Initialize grid with -1
    int** grid = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        grid[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            grid[i][j] = -1;
        }
    }

    int* visited = (int*)calloc(n, sizeof(int));
    grid[0][0] = start;
    visited[start] = 1;

    // First row
    int current = start;
    int prev = -1;
    for (int j = 1; j < cols; j++) {
        for (int k = 0; k < deg[current]; k++) {
            int next = adj[current][k];
            if (!visited[next] && next != prev) {
                grid[0][j] = next;
                visited[next] = 1;
                prev = current;
                current = next;
                break;
            }
        }
    }

    // Fill remaining rows
    for (int i = 1; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i-1][j] != -1) {
                for (int k = 0; k < deg[grid[i-1][j]]; k++) {
                    int neighbor = adj[grid[i-1][j]][k];
                    if (!visited[neighbor]) {
                        grid[i][j] = neighbor;
                        visited[neighbor] = 1;
                        break;
                    }
                }
            }
        }
    }

    // Clean up
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(deg);
    free(visited);

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    return grid;
}