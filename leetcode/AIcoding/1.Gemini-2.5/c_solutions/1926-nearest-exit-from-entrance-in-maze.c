#include <stdbool.h>

typedef struct {
    int r;
    int c;
    int steps;
} QueueNode;

#define MAX_MAZE_DIM 100
QueueNode queue[MAX_MAZE_DIM * MAX_MAZE_DIM];
int head = 0;
int tail = 0;

bool visited[MAX_MAZE_DIM][MAX_MAZE_DIM];

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int nearestExit(char** maze, int mazeSize, int* mazeColSize, int* entrance) {
    int m = mazeSize;
    int n = mazeColSize[0];

    head = 0;
    tail = 0;
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            visited[i][j] = false;
        }
    }

    int start_r = entrance[0];
    int start_c = entrance[1];

    queue[tail++] = (QueueNode){start_r, start_c, 0};
    visited[start_r][start_c] = true;

    while (head < tail) {
        QueueNode current = queue[head++];
        int r = current.r;
        int c = current.c;
        int steps = current.steps;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                if (maze[nr][nc] == '.' && !visited[nr][nc]) {
                    visited[nr][nc] = true;

                    if ((nr == 0 || nr == m - 1 || nc == 0 || nc == n - 1) &&
                        !(nr == start_r && nc == start_c)) {
                        return steps + 1;
                    }

                    queue[tail++] = (QueueNode){nr, nc, steps + 1};
                }
            }
        }
    }

    return -1;
}