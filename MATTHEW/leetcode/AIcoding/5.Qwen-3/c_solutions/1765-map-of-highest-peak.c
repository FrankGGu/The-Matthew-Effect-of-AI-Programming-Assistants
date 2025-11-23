#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int row;
    int col;
} Point;

int** highPeak(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)calloc(cols, sizeof(int));
    }

    int** queue = (int**)malloc(rows * cols * sizeof(int*));
    int front = 0;
    int rear = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0) {
                result[i][j] = 0;
                visited[i][j] = 1;
                queue[rear++] = (int*)malloc(2 * sizeof(int));
                queue[rear - 1][0] = i;
                queue[rear - 1][1] = j;
            }
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (front < rear) {
        int* current = queue[front++];
        int x = current[0];
        int y = current[1];

        for (int i = 0; i < 4; i++) {
            int nx = x + directions[i][0];
            int ny = y + directions[i][1];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                visited[nx][ny] = 1;
                result[nx][ny] = result[x][y] + 1;
                queue[rear++] = (int*)malloc(2 * sizeof(int));
                queue[rear - 1][0] = nx;
                queue[rear - 1][1] = ny;
            }
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);

    for (int i = 0; i < rows * cols; i++) {
        free(queue[i]);
    }
    free(queue);

    return result;
}