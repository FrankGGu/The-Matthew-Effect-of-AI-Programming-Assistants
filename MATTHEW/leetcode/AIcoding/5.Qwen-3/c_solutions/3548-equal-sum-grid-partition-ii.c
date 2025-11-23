#include <stdio.h>
#include <stdlib.h>

int** gridPartition(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int total = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            total += grid[i][j];
        }
    }
    if (total % k != 0) return NULL;

    int target = total / k;
    int** result = (int**)malloc(k * sizeof(int*));
    for (int i = 0; i < k; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    int* sum = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) sum[i] = 0;

    int* used = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) used[i] = 0;

    int* rowIndices = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) rowIndices[i] = i;

    int** temp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        temp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) temp[i][j] = grid[i][j];
    }

    int* count = (int*)malloc(k * sizeof(int));

    for (int i = 0; i < k; i++) {
        count[i] = 0;
    }

    int idx = 0;
    for (int i = 0; i < k; i++) {
        while (idx < rows && sum[i] < target) {
            int row = rowIndices[idx];
            int rowSum = 0;
            for (int j = 0; j < cols; j++) rowSum += temp[row][j];
            if (sum[i] + rowSum <= target) {
                for (int j = 0; j < cols; j++) {
                    result[i][j] += temp[row][j];
                }
                sum[i] += rowSum;
                used[row] = 1;
                count[i]++;
                idx++;
            } else {
                break;
            }
        }
    }

    for (int i = 0; i < k; i++) {
        if (sum[i] != target) {
            for (int j = 0; j < k; j++) free(result[j]);
            free(result);
            free(sum);
            free(used);
            free(rowIndices);
            for (int j = 0; j < rows; j++) free(temp[j]);
            free(temp);
            free(count);
            return NULL;
        }
    }

    return result;
}