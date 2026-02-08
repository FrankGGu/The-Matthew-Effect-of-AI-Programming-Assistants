#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** highestPeak(int** isWater, int isWaterSize, int* isWaterColSize, int* returnSize, int** returnColumnSizes){
    int rows = isWaterSize;
    int cols = *isWaterColSize;

    int** result = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    *returnSize = rows;

    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
        for (int j = 0; j < cols; j++) {
            result[i][j] = -1; 
        }
    }

    int queue[rows * cols][2];
    int head = 0, tail = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (isWater[i][j] == 1) {
                result[i][j] = 0;
                queue[tail][0] = i;
                queue[tail][1] = j;
                tail++;
            }
        }
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (head < tail) {
        int x = queue[head][0];
        int y = queue[head][1];
        head++;

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && result[nx][ny] == -1) {
                result[nx][ny] = result[x][y] + 1;
                queue[tail][0] = nx;
                queue[tail][1] = ny;
                tail++;
            }
        }
    }

    return result;
}