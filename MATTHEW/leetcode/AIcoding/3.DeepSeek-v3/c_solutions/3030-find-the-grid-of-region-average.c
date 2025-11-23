/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** resultGrid(int** image, int imageSize, int* imageColSize, int threshold, int* returnSize, int** returnColumnSizes) {
    int m = imageSize;
    int n = *imageColSize;

    int** result = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            result[i][j] = image[i][j];
        }
    }

    int** sum = (int**)calloc(m, sizeof(int*));
    int** count = (int**)calloc(m, sizeof(int*));
    for (int i = 0; i < m; i++) {
        sum[i] = (int*)calloc(n, sizeof(int));
        count[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i <= m - 3; i++) {
        for (int j = 0; j <= n - 3; j++) {
            bool valid = true;
            for (int x = i; x < i + 3; x++) {
                for (int y = j; y < j + 3; y++) {
                    if (x > i && abs(image[x][y] - image[x-1][y]) > threshold) {
                        valid = false;
                        break;
                    }
                    if (y > j && abs(image[x][y] - image[x][y-1]) > threshold) {
                        valid = false;
                        break;
                    }
                }
                if (!valid) break;
            }

            if (valid) {
                int total = 0;
                for (int x = i; x < i + 3; x++) {
                    for (int y = j; y < j + 3; y++) {
                        total += image[x][y];
                    }
                }
                int avg = total / 9;

                for (int x = i; x < i + 3; x++) {
                    for (int y = j; y < j + 3; y++) {
                        sum[x][y] += avg;
                        count[x][y]++;
                    }
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (count[i][j] > 0) {
                result[i][j] = sum[i][j] / count[i][j];
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(sum[i]);
        free(count[i]);
    }
    free(sum);
    free(count);

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    return result;
}