#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
} Point;

int shortestPathBinaryMatrix(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;

    if (grid[0][0] != 0 || grid[rows - 1][cols - 1] != 0) {
        return -1;
    }

    int directions[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    dist[0][0] = 1;

    Point queue[rows * cols];
    int front = 0, rear = 0;
    queue[rear].row = 0;
    queue[rear++].col = 0;

    while (front < rear) {
        Point current = queue[front++];
        int r = current.row;
        int c = current.col;

        if (r == rows - 1 && c == cols - 1) {
            break;
        }

        for (int i = 0; i < 8; i++) {
            int nr = r + directions[i][0];
            int nc = c + directions[i][1];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == 0 && dist[nr][nc] > dist[r][c] + 1) {
                dist[nr][nc] = dist[r][c] + 1;
                queue[rear].row = nr;
                queue[rear++].col = nc;
            }
        }
    }

    int result = dist[rows - 1][cols - 1];
    for (int i = 0; i < rows; i++) {
        free(dist[i]);
    }
    free(dist);

    return result == INT_MAX ? -1 : result;
}