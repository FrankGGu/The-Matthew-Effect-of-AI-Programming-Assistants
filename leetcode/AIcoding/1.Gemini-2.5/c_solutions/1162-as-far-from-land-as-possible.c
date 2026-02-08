#include <stdlib.h>

typedef struct {
    int r, c;
} Point;

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int maxDistance(int** grid, int gridSize, int* gridColSize) {
    int N = gridSize;
    int M = gridColSize[0];

    Point* queue = (Point*)malloc(sizeof(Point) * N * M);
    int head = 0, tail = 0;
    int landCount = 0;

    for (int r = 0; r < N; ++r) {
        for (int c = 0; c < M; ++c) {
            if (grid[r][c] == 1) {
                queue[tail++] = (Point){r, c};
                landCount++;
            }
        }
    }

    if (landCount == 0 || landCount == N * M) {
        free(queue);
        return -1;
    }

    int distance = -1;

    while (head < tail) {
        int levelSize = tail - head;
        distance++; 

        for (int i = 0; i < levelSize; ++i) {
            Point current = queue[head++];

            for (int j = 0; j < 4; ++j) {
                int nr = current.r + dr[j];
                int nc = current.c + dc[j];

                if (nr >= 0 && nr < N && nc >= 0 && nc < M && grid[nr][nc] == 0) {
                    grid[nr][nc] = 1; 
                    queue[tail++] = (Point){nr, nc};
                }
            }
        }
    }

    free(queue);
    return distance; 
}