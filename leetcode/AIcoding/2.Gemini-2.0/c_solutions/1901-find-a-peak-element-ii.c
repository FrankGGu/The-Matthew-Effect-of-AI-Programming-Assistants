#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findPeakGrid(int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];
    int left = 0, right = m - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int maxColIndex = 0;
        for (int j = 1; j < n; j++) {
            if (mat[mid][j] > mat[mid][maxColIndex]) {
                maxColIndex = j;
            }
        }

        if (mid > 0 && mat[mid][maxColIndex] < mat[mid - 1][maxColIndex]) {
            right = mid - 1;
        } else if (mid < m - 1 && mat[mid][maxColIndex] < mat[mid + 1][maxColIndex]) {
            left = mid + 1;
        } else {
            return mid * 10000 + maxColIndex;
        }
    }
    return -1;
}