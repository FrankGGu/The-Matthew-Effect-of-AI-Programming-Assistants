#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

typedef struct {
    int x, y, time;
} Point;

int minTimeToVisitCell(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
    int maxTime = INT_MAX;
    bool visited[gridSize][*gridColSize];
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            visited[i][j] = false;
        }
    }

    Point queue[gridSize * (*gridColSize)];
    int front = 0, rear = 0;
    queue[rear++] = (Point){0, 0, grid[0][0]};
    visited[0][0] = true;

    while (front < rear) {
        Point current = queue[front++];
        if (current.x == gridSize - 1 && current.y == *gridColSize - 1) {
            return current.time;
        }
        for (int i = 0; i < 4; i++) {
            int newX = current.x + directions[i][0];
            int newY = current.y + directions[i][1];
            if (newX >= 0 && newX < gridSize && newY >= 0 && newY < *gridColSize) {
                int newTime = current.time + grid[newX][newY];
                if (!visited[newX][newY] || newTime < maxTime) {
                    visited[newX][newY] = true;
                    queue[rear++] = (Point){newX, newY, newTime};
                }
            }
        }
    }

    return -1;
}