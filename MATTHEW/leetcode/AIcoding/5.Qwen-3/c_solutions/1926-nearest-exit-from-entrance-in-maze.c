#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int x;
    int y;
} Point;

int nearestExit(char** maze, int mazeSize, int* mazeColSize, int entranceRow, int entranceCol) {
    int rows = mazeSize;
    int cols = mazeColSize[0];

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    int queueSize = rows * cols;
    Point* queue = (Point*)malloc(queueSize * sizeof(Point));
    bool* visited = (bool*)calloc(rows * cols, sizeof(bool));

    int front = 0, rear = 0;

    Point start = {entranceRow, entranceCol};
    queue[rear++] = start;
    visited[entranceRow * cols + entranceCol] = true;

    int steps = 0;

    while (front < rear) {
        int levelSize = rear - front;

        for (int i = 0; i < levelSize; i++) {
            Point current = queue[front++];

            for (int d = 0; d < 4; d++) {
                int nx = current.x + directions[d][0];
                int ny = current.y + directions[d][1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx * cols + ny]) {
                    if (nx == 0 || nx == rows - 1 || ny == 0 || ny == cols - 1) {
                        free(queue);
                        free(visited);
                        return steps + 1;
                    }

                    visited[nx * cols + ny] = true;
                    queue[rear++] = (Point){nx, ny};
                }
            }
        }

        steps++;
    }

    free(queue);
    free(visited);
    return -1;
}