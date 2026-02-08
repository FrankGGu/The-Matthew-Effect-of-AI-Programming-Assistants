#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int r;
    int c;
    int dist;
} Cell;

int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

int shortestPathBinaryMatrix(int** grid, int gridSize, int* gridColSize) {
    int N = gridSize;
    int M = gridColSize[0];

    if (grid[0][0] == 1 || grid[N - 1][M - 1] == 1) {
        return -1;
    }

    if (N == 1 && M == 1) {
        return 1;
    }

    Cell* queue = (Cell*)malloc(sizeof(Cell) * N * M);
    int front = 0;
    int rear = 0;

    queue[rear++] = (Cell){0, 0, 1};
    grid[0][0] = 1;

    while (front < rear) {
        Cell current = queue[front++];

        if (current.r == N - 1 && current.c == M - 1) {
            free(queue);
            return current.dist;
        }

        for (int i = 0; i < 8; i++) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];

            if (nr >= 0 && nr < N && nc >= 0 && nc < M && grid[nr][nc] == 0) {
                grid[nr][nc] = 1;
                queue[rear++] = (Cell){nr, nc, current.dist + 1};
            }
        }
    }

    free(queue);
    return -1;
}