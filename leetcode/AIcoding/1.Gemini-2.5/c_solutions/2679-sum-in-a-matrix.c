#include <stdlib.h> // For qsort

int compareInt(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int matrixSum(int** nums, int numsSize, int* numsColSize) {
    int m = numsSize;
    int n = numsColSize[0]; // All rows have the same number of columns

    for (int i = 0; i < m; i++) {
        qsort(nums[i], n, sizeof(int), compareInt);
    }

    int totalSum = 0;

    for (int j = 0; j < n; j++) { // Iterate n times for n operations
        int maxInOperation = 0;
        for (int i = 0; i < m; i++) { // Find the maximum element among the current largest elements of each row
            // Since rows are sorted ascending, nums[i][n - 1 - j] gives the j-th largest element (0-indexed from right)
            if (nums[i][n - 1 - j] > maxInOperation) {
                maxInOperation = nums[i][n - 1 - j];
            }
        }
        totalSum += maxInOperation;
    }

    return totalSum;
}