#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) return 1;
    if (valA > valB) return -1;
    return 0;
}

int* getBiggestThreeRhombusSums(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];

    long long* allSums = (long long*)malloc(sizeof(long long) * (m * n * (50 / 2 + 1))); // Max possible sums
    int sumCount = 0;

    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            // Case k = 0 (single cell rhombus)
            allSums[sumCount++] = grid[r][c];

            // Case k > 0 (actual rhombus)
            for (int k = 1; ; ++k) {
                if (r - k < 0 || r + k >= m || c - k < 0 || c + k >= n) {
                    break; 
                }

                long long currentSum = 0;

                // Sum points on the rhombus perimeter
                // Top-left to Top-right segment
                for (int i = 0; i <= k; ++i) {
                    currentSum += grid[r - k + i][c + i];
                }
                // Top-right to Bottom-right segment (excluding Top-right peak already added)
                for (int i = 1; i <= k; ++i) {
                    currentSum += grid[r + i][c + k - i];
                }
                // Bottom-right to Bottom-left segment (excluding Bottom-right peak already added)
                for (int i = 1; i <= k; ++i) {
                    currentSum += grid[r + k - i][c - i];
                }
                // Bottom-left to Top-left segment (excluding Bottom-left peak and Top-left peak already added)
                for (int i = 1; i < k; ++i) { 
                    currentSum += grid[r - i][c - k + i];
                }

                allSums[sumCount++] = currentSum;
            }
        }
    }

    qsort(allSums, sumCount, sizeof(long long), compare);

    long long* uniqueSums = (long long*)malloc(sizeof(long long) * sumCount); 
    int uniqueCount = 0;
    if (sumCount > 0) {
        uniqueSums[uniqueCount++] = allSums[0];
        for (int i = 1; i < sumCount; ++i) {
            if (allSums[i] != allSums[i-1]) {
                uniqueSums[uniqueCount++] = allSums[i];
            }
        }
    }

    int resultSize = (uniqueCount < 3) ? uniqueCount : 3;
    int* result = (int*)malloc(sizeof(int) * resultSize);
    for (int i = 0; i < resultSize; ++i) {
        result[i] = (int)uniqueSums[i];
    }

    *returnSize = resultSize;

    free(allSums);
    free(uniqueSums);

    return result;
}