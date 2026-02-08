/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* getBiggestThree(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize, n = gridColSize[0];
    int maxSums[3] = {0};
    int count = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; i + 2 * k < m && j - k >= 0 && j + k < n; k++) {
                int sum = 0;
                if (k == 0) {
                    sum = grid[i][j];
                } else {
                    int x1 = i, y1 = j - k;
                    int x2 = i + k, y2 = j;
                    int x3 = i + 2 * k, y3 = j;
                    int x4 = i + k, y4 = j + k;

                    for (int d = 0; d < k; d++) {
                        sum += grid[x1 + d][y1 + d];
                        sum += grid[x2 + d][y2 - d];
                        sum += grid[x3 - d][y3 - d];
                        sum += grid[x4 - d][y4 + d];
                    }
                }

                int pos = -1;
                for (int idx = 0; idx < count; idx++) {
                    if (maxSums[idx] == sum) {
                        pos = idx;
                        break;
                    }
                }
                if (pos != -1) continue;

                if (count == 0) {
                    maxSums[0] = sum;
                    count = 1;
                } else if (count == 1) {
                    if (sum > maxSums[0]) {
                        maxSums[1] = maxSums[0];
                        maxSums[0] = sum;
                        count = 2;
                    } else if (sum < maxSums[0]) {
                        maxSums[1] = sum;
                        count = 2;
                    }
                } else if (count == 2) {
                    if (sum > maxSums[0]) {
                        maxSums[2] = maxSums[1];
                        maxSums[1] = maxSums[0];
                        maxSums[0] = sum;
                        count = 3;
                    } else if (sum < maxSums[0] && sum > maxSums[1]) {
                        maxSums[2] = maxSums[1];
                        maxSums[1] = sum;
                        count = 3;
                    } else if (sum < maxSums[1]) {
                        maxSums[2] = sum;
                        count = 3;
                    }
                } else {
                    if (sum > maxSums[0]) {
                        maxSums[2] = maxSums[1];
                        maxSums[1] = maxSums[0];
                        maxSums[0] = sum;
                    } else if (sum < maxSums[0] && sum > maxSums[1]) {
                        maxSums[2] = maxSums[1];
                        maxSums[1] = sum;
                    } else if (sum < maxSums[1] && sum > maxSums[2]) {
                        maxSums[2] = sum;
                    }
                }
            }
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        result[i] = maxSums[i];
    }
    *returnSize = count;
    return result;
}