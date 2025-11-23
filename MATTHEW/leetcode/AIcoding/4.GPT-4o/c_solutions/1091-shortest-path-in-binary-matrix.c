#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_N 100

typedef struct {
    int x, y;
} Point;

int directions[8][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

int shortestPathBinaryMatrix(int** grid, int gridSize, int* gridColSize) {
    if (grid[0][0] == 1 || grid[gridSize - 1][gridColSize[0] - 1] == 1) {
        return -1;
    }

    int queue[MAX_N * MAX_N][2];
    int front = 0, rear = 0;
    queue[rear][0] = 0; 
    queue[rear][1] = 0; 
    rear++;

    bool visited[MAX_N][MAX_N] = {false};
    visited[0][0] = true;

    int pathLength = 1;

    while (front < rear) {
        int size = rear - front;

        for (int i = 0; i < size; i++) {
            Point current = {queue[front][0], queue[front][1]};
            front++;

            if (current.x == gridSize - 1 && current.y == gridColSize[0] - 1) {
                return pathLength;
            }

            for (int j = 0; j < 8; j++) {
                int newX = current.x + directions[j][0];
                int newY = current.y + directions[j][1];

                if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridColSize[0] && 
                    grid[newX][newY] == 0 && !visited[newX][newY]) {
                    visited[newX][newY] = true;
                    queue[rear][0] = newX;
                    queue[rear][1] = newY;
                    rear++;
                }
            }
        }
        pathLength++;
    }

    return -1;
}