#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* kthSmallestPrimeFraction(int* arr, int arrSize, int k, int* returnSize) {
    double left = 0.0, right = 1.0;
    while (left < right) {
        double mid = left + (right - left) / 2.0;
        int count = 0, j = arrSize - 1;
        for (int i = 0; i < arrSize; i++) {
            while (j >= 0 && (double)arr[i] > mid * arr[j]) {
                j--;
            }
            count += (j + 1);
        }
        if (count < k) {
            left = mid;
        } else {
            right = mid;
        }
    }

    int* p = NULL, *q = NULL;
    double fraction = 1.0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            double temp = (double)arr[i] / arr[j];
            if (abs(temp - left) < 1e-9 && temp < fraction) {
                fraction = temp;
                p = &arr[i];
                q = &arr[j];
            }
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = *p;
    result[1] = *q;
    *returnSize = 2;
    return result;
}