#include <stdlib.h> // For malloc, calloc, free

typedef struct {
    int r;
    int c;
} Point;

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int** colorBorder(int** grid, int gridSize, int* gridColSize, int r0, int c0, int color) {
    int R = gridSize;
    int C = gridColSize[0]; // Assuming a rectangular grid

    int originalColor = grid[r0][c0];

    // visited[r][c] = 0: not visited
    // visited[r][c] = 1: visited, part of component, interior (tentative)
    // visited[r][c] = 2: visited, part of component, border
    int** visited = (int**)malloc(R * sizeof(int*));
    for (int i = 0; i < R; i++) {
        visited[i] = (int*)calloc(C, sizeof(int)); // calloc initializes to 0
    }

    // BFS Queue
    Point* queue = (Point*)malloc(R * C * sizeof(Point));
    int head = 0;
    int tail = 0;

    // Start BFS from (r0, c0)
    queue[tail++] = (Point){r0, c0};
    visited[r0][c0] = 1; // Mark as visited (tentatively interior)

    while (head < tail) {
        Point current = queue[head++];
        int r = current.r;
        int c = current.c;

        // Check if current cell (r, c) is a border cell
        int isBorder = 0;
        if (r == 0 || r == R - 1 || c == 0 || c == C - 1) {
            isBorder = 1; // On grid boundary
        } else {
            // Check neighbors
            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // If a neighbor is out of bounds OR has a different color
                if (nr < 0 || nr >= R || nc < 0 || nc >= C || grid[nr][nc] != originalColor) {
                    isBorder = 1;
                    break;
                }
            }
        }

        if (isBorder) {
            visited[r][c] = 2; // Mark as border
        } else {
            visited[r][c] = 1; // Mark as interior (already 1, but confirm)
        }

        // Explore neighbors
        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // If neighbor is within bounds, has originalColor, and not visited
            if (nr >= 0 && nr < R && nc >= 0 && nc < C &&
                grid[nr][nc] == originalColor && visited[nr][nc] == 0) {

                visited[nr][nc] = 1; // Mark as visited (tentatively interior)
                queue[tail++] = (Point){nr, nc};
            }
        }
    }

    // Apply new color to border cells
    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            if (visited[i][j] == 2) {
                grid[i][j] = color;
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < R; i++) {
        free(visited[i]);
    }
    free(visited);
    free(queue);

    return grid;
}