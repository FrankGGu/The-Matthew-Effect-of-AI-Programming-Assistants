#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int x, y, time;
} State;

int minTime(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int rows = gridSize, cols = gridColSize[0];
    int** timeGrid = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        timeGrid[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            timeGrid[i][j] = INT_MAX;
        }
    }

    timeGrid[0][0] = 0;
    State* queue = (State*)malloc(rows * cols * sizeof(State));
    int front = 0, rear = 0;
    queue[rear++] = (State){0, 0, 0};

    while (front < rear) {
        State current = queue[front++];
        int curTime = current.time;

        for (int i = 0; i < 4; i++) {
            int newX = current.x + directions[i][0];
            int newY = current.y + directions[i][1];
            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols) {
                int newTime = curTime + grid[newX][newY];
                if (newTime < timeGrid[newX][newY]) {
                    timeGrid[newX][newY] = newTime;
                    queue[rear++] = (State){newX, newY, newTime};
                }
            }
        }
    }

    int result = timeGrid[rows - 1][cols - 1];

    for (int i = 0; i < rows; i++) {
        free(timeGrid[i]);
    }
    free(timeGrid);
    free(queue);

    return result == INT_MAX ? -1 : result;
}