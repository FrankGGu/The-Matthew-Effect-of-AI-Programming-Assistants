#include <stdio.h>
#include <stdlib.h>

int** colorBorder(int** grid, int gridSize, int* gridColSize, int x, int y, int color, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int originalColor = grid[x][y];
    if (originalColor == color) {
        *returnSize = rows;
        *returnColumnSizes = (int*)malloc(rows * sizeof(int));
        for (int i = 0; i < rows; i++) {
            (*returnColumnSizes)[i] = cols;
        }
        return grid;
    }

    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            result[i][j] = grid[i][j];
        }
    }

    int dx[] = {-1, 0, 1, 0};
    int dy[] = {0, 1, 0, -1};

    int* queue = (int*)malloc(rows * cols * 2 * sizeof(int));
    int front = 0, rear = 0;

    queue[rear++] = x;
    queue[rear++] = y;

    int visited[rows][cols];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            visited[i][j] = 0;
        }
    }

    visited[x][y] = 1;

    while (front < rear) {
        int currX = queue[front++];
        int currY = queue[front++;

        for (int k = 0; k < 4; k++) {
            int nx = currX + dx[k];
            int ny = currY + dy[k];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny] && grid[nx][ny] == originalColor) {
                visited[nx][ny] = 1;
                queue[rear++] = nx;
                queue[rear++] = ny;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (visited[i][j]) {
                int isBorder = 0;
                for (int k = 0; k < 4; k++) {
                    int ni = i + dx[k];
                    int nj = j + dy[k];
                    if (ni < 0 || ni >= rows || nj < 0 || nj >= cols || !visited[ni][nj]) {
                        isBorder = 1;
                        break;
                    }
                }
                if (isBorder) {
                    result[i][j] = color;
                }
            }
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    free(queue);
    return result;
}