#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int abs(int x) {
    return x < 0 ? -x : x;
}

int orangesRotting(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int queue[rows * cols][2];
    int front = 0, rear = 0;
    int fresh = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                fresh++;
            } else if (grid[i][j] == 2) {
                queue[rear][0] = i;
                queue[rear][1] = j;
                rear++;
            }
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int time = 0;

    while (front < rear && fresh > 0) {
        int size = rear - front;
        for (int k = 0; k < size; k++) {
            int x = queue[front][0];
            int y = queue[front][1];
            front++;
            for (int d = 0; d < 4; d++) {
                int nx = x + directions[d][0];
                int ny = y + directions[d][1];
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx][ny] == 1) {
                    grid[nx][ny] = 2;
                    queue[rear][0] = nx;
                    queue[rear][1] = ny;
                    rear++;
                    fresh--;
                }
            }
        }
        time++;
    }

    return fresh == 0 ? time : -1;
}