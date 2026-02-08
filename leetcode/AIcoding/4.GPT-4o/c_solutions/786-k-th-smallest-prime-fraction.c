#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(double *)a > *(double *)b) - (*(double *)a < *(double *)b);
}

double kthSmallestPrimeFraction(int* arr, int arrSize, int k) {
    double left = 0.0, right = 1.0;
    while (right - left > 1e-9) {
        double mid = (left + right) / 2;
        int count = 0, maxNum = 0, maxDen = 1;
        for (int j = 0, i = 1; i < arrSize; i++) {
            while (j < i && arr[j] < mid * arr[i]) {
                j++;
            }
            count += j;
            if (j > 0) {
                double frac = (double)arr[j - 1] / arr[i];
                if (frac > (double)maxNum / maxDen) {
                    maxNum = arr[j - 1];
                    maxDen = arr[i];
                }
            }
        }
        if (count < k) {
            left = mid;
        } else {
            right = mid;
        }
    }
    return (double)maxNum / maxDen;
}

double* kthSmallestPrimeFraction(int* arr, int arrSize, int k, int* returnSize) {
    double* result = (double*)malloc(2 * sizeof(double));
    double fraction = kthSmallestPrimeFraction(arr, arrSize, k);
    result[0] = (double)(int)(fraction * 1e9) / 1e9;
    result[1] = (double)(int)(fraction * 1e9) / 1e9;
    *returnSize = 2;
    return result;
}