#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findKthLargest(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int* xors = (int*)malloc(sizeof(int) * m * n);
    int index = 0;

    xors[0] = matrix[0][0];
    index++;

    for (int i = 1; i < n; i++) {
        xors[index++] = xors[index - 2] ^ matrix[0][i];
    }

    for (int i = 1; i < m; i++) {
        xors[index++] = xors[index - n -1] ^ matrix[i][0];
    }

    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            xors[index++] = xors[index - n -1] ^ xors[index - 2] ^ xors[index - n - n - 2] ^ matrix[i][j];
        }
    }

    int left = 0;
    int right = m * n - 1;
    int kthIndex = m * n - k;

    while (left <= right) {
        int pivotIndex = left;
        int pivotValue = xors[right];
        for (int i = left; i < right; i++) {
            if (xors[i] <= pivotValue) {
                int temp = xors[i];
                xors[i] = xors[pivotIndex];
                xors[pivotIndex] = temp;
                pivotIndex++;
            }
        }
        xors[right] = xors[pivotIndex];
        xors[pivotIndex] = pivotValue;

        if (pivotIndex == kthIndex) {
            int result = xors[pivotIndex];
            free(xors);
            return result;
        } else if (pivotIndex < kthIndex) {
            left = pivotIndex + 1;
        } else {
            right = pivotIndex - 1;
        }
    }

    int result = xors[kthIndex];
    free(xors);
    return result;
}