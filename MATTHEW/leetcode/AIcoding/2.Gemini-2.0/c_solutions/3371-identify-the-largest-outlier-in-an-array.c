#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestOutlier(int arr[], int arrSize) {
    if (arrSize < 3) {
        return -1;
    }

    int temp[arrSize];
    for (int i = 0; i < arrSize; i++) {
        temp[i] = arr[i];
    }

    for (int i = 0; i < arrSize - 1; i++) {
        for (int j = 0; j < arrSize - i - 1; j++) {
            if (temp[j] > temp[j + 1]) {
                int swap = temp[j];
                temp[j] = temp[j + 1];
                temp[j + 1] = swap;
            }
        }
    }

    int q1 = temp[arrSize / 4];
    int q3 = temp[arrSize * 3 / 4];
    int iqr = q3 - q1;
    int upper_bound = q3 + 1.5 * iqr;
    int lower_bound = q1 - 1.5 * iqr;

    int largest_outlier = -1;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > upper_bound || arr[i] < lower_bound) {
            if (largest_outlier == -1) {
                largest_outlier = arr[i];
            } else if (abs(arr[i]) > abs(largest_outlier)) {
                largest_outlier = arr[i];
            }
        }
    }

    return largest_outlier;
}