#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
} Position;

int orangesRotting(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int queueSize = 0;
    int front = 0;
    int rear = 0;
    Position* queue = (Position*)malloc(rows * cols * sizeof(Position));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 2) {
                queue[rear++] = (Position){i, j};
                queueSize++;
            }
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int time = 0;

    while (queueSize > 0) {
        int levelSize = queueSize;
        for (int k = 0; k < levelSize; k++) {
            Position current = queue[front++];
            queueSize--;

            for (int d = 0; d < 4; d++) {
                int newRow = current.row + directions[d][0];
                int newCol = current.col + directions[d][1];

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == 1) {
                    grid[newRow][newCol] = 2;
                    queue[rear++] = (Position){newRow, newCol};
                    queueSize++;
                }
            }
        }
        time++;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                free(queue);
                return -1;
            }
        }
    }

    free(queue);
    return time > 0 ? time - 1 : 0;
}