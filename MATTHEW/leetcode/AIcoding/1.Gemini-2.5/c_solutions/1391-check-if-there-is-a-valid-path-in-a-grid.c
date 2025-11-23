#include <stdbool.h>
#include <stdlib.h> // For malloc, calloc, free

static int dr[] = {-1, 1, 0, 0};
static int dc[] = {0, 0, -1, 1};
static int opposite_dir[] = {1, 0, 3, 2};

static bool can_connect[7][4] = {
    // Street 0 (unused)
    {false, false, false, false},
    // Street 1: Left, Right
    {false, false, true, true},
    // Street 2: Up, Down
    {true, true, false, false},
    // Street 3: Left, Down
    {false, true, true, false},
    // Street 4: Right, Down
    {false, true, false, true},
    // Street 5: Left, Up
    {true, false, true, false},
    // Street 6: Right, Up
    {true, false, false, true}
};

typedef struct {
    int r;
    int c;
} Point;

bool hasValidPath(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 0 || n == 0) {
        return false;
    }

    bool** visited = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        visited[i] = (bool*)calloc(n, sizeof(bool)); // calloc initializes to false
    }

    Point* queue = (Point*)malloc(m * n * sizeof(Point));
    int head = 0;
    int tail = 0;

    queue[tail++] = (Point){0, 0};
    visited[0][0] = true;

    bool path_found = false;

    while (head < tail) {
        Point curr = queue[head++];
        int r = curr.r;
        int c = curr.c;

        if (r == m - 1 && c == n - 1) {
            path_found = true;
            break;
        }

        int current_street_type = grid[r][c];

        for (int i = 0; i < 4; i++) { // Iterate through 4 directions (Up, Down, Left, Right)
            if (!can_connect[current_street_type][i]) {
                continue; // Current street does not allow movement in this direction
            }

            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check bounds
            if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                continue;
            }

            if (!visited[nr][nc]) {
                int next_street_type = grid[nr][nc];
                // Check if the next street allows an incoming connection from the current street
                if (can_connect[next_street_type][opposite_dir[i]]) {
                    visited[nr][nc] = true;
                    queue[tail++] = (Point){nr, nc};
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(visited[i]);
    }
    free(visited);
    free(queue);

    return path_found;
}