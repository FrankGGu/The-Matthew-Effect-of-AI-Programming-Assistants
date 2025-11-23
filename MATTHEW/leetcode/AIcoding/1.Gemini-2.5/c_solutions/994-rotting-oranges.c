#include <stdbool.h>

typedef struct {
    int r, c;
} Point;

int orangesRotting(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    Point queue[m * n];
    int head = 0, tail = 0;

    int freshOranges = 0;
    int time = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 2) {
                queue[tail++] = (Point){i, j};
            } else if (grid[i][j] == 1) {
                freshOranges++;
            }
        }
    }

    if (freshOranges == 0) {
        return 0;
    }

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (head < tail) {
        int levelSize = tail - head;
        bool newRottenThisMinute = false;

        for (int i = 0; i < levelSize; i++) {
            Point current = queue[head++];

            for (int k = 0; k < 4; k++) {
                int nr = current.r + dr[k];
                int nc = current.c + dc[k];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] == 1) {
                    grid[nr][nc] = 2;
                    queue[tail++] = (Point){nr, nc};
                    freshOranges--;
                    newRottenThisMinute = true;
                }
            }
        }

        if (newRottenThisMinute) {
            time++;
        }
    }

    if (freshOranges > 0) {
        return -1;
    } else {
        return time;
    }
}