#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
    int dist;
} QueueNode;

int shortestPathBinaryMatrix(int** grid, int gridSize, int* gridColSize) {
    if (grid[0][0] == 1 || grid[gridSize - 1][*gridColSize - 1] == 1) {
        return -1;
    }

    if (gridSize == 1 && *gridColSize == 1 && grid[0][0] == 0) return 1;

    int rows = gridSize;
    int cols = *gridColSize;

    int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
    int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};

    QueueNode* queue = (QueueNode*)malloc(rows * cols * sizeof(QueueNode));
    int head = 0;
    int tail = 0;

    grid[0][0] = 1;
    queue[tail].x = 0;
    queue[tail].y = 0;
    queue[tail].dist = 1;
    tail++;

    while (head < tail) {
        QueueNode curr = queue[head];
        head++;

        if (curr.x == rows - 1 && curr.y == cols - 1) {
            free(queue);
            return curr.dist;
        }

        for (int i = 0; i < 8; i++) {
            int nx = curr.x + dx[i];
            int ny = curr.y + dy[i];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx][ny] == 0) {
                grid[nx][ny] = curr.dist + 1;
                queue[tail].x = nx;
                queue[tail].y = ny;
                queue[tail].dist = curr.dist + 1;
                tail++;
            }
        }
    }

    free(queue);
    return -1;
}