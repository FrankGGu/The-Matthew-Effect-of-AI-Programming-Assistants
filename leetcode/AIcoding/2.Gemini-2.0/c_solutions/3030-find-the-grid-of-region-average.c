#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** average(int** image, int imageSize, int* imageColSize, int threshold, int* returnSize, int** returnColumnSizes){
    int rows = imageSize;
    int cols = imageColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    *returnSize = rows;

    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
        for (int j = 0; j < cols; j++) {
            result[i][j] = image[i][j];
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (result[i][j] != image[i][j]) continue;

            int sum = 0;
            int count = 0;
            int x_min = i, x_max = i, y_min = j, y_max = j;
            int queue_size = rows * cols;
            int** queue = (int**)malloc(queue_size * sizeof(int*));
            for (int k = 0; k < queue_size; k++) {
                queue[k] = (int*)malloc(2 * sizeof(int));
            }
            int head = 0, tail = 0;
            queue[tail][0] = i;
            queue[tail][1] = j;
            tail++;

            result[i][j] = -1;

            while (head < tail) {
                int x = queue[head][0];
                int y = queue[head][1];
                head++;

                sum += image[x][y];
                count++;

                x_min = (x < x_min) ? x : x_min;
                x_max = (x > x_max) ? x : x_max;
                y_min = (y < y_min) ? y : y_min;
                y_max = (y > y_max) ? y : y_max;

                int dx[] = {0, 0, 1, -1};
                int dy[] = {1, -1, 0, 0};

                for (int k = 0; k < 4; k++) {
                    int nx = x + dx[k];
                    int ny = y + dy[k];

                    if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && result[nx][ny] == image[nx][ny] && abs(image[x][y] - image[nx][ny]) <= threshold) {
                        queue[tail][0] = nx;
                        queue[tail][1] = ny;
                        tail++;
                        result[nx][ny] = -1;
                    }
                }
            }

            int avg = sum / count;

            for (int x = x_min; x <= x_max; x++) {
                for (int y = y_min; y <= y_max; y++) {
                   if (image[x][y] == image[x_min][y_min] && result[x][y] == -1){
                        result[x][y] = avg;
                    }
                }
            }

            for (int k = 0; k < queue_size; k++) {
                free(queue[k]);
            }
            free(queue);

        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (result[i][j] == -1){
                result[i][j] = image[i][j];
            }
        }
    }

    return result;
}