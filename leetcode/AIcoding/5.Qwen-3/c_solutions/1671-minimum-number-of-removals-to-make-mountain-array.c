#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int longestMountain(int* arr, int arrSize) {
    int n = arrSize;
    int* up = (int*)malloc(n * sizeof(int));
    int* down = (int*)malloc(n * sizeof(int));

    for (int i = 1; i < n; i++) {
        if (arr[i] > arr[i - 1]) {
            up[i] = up[i - 1] + 1;
        } else {
            up[i] = 0;
        }
    }

    for (int i = n - 2; i >= 0; i--) {
        if (arr[i] > arr[i + 1]) {
            down[i] = down[i + 1] + 1;
        } else {
            down[i] = 0;
        }
    }

    int max = 0;
    for (int i = 0; i < n; i++) {
        if (up[i] > 0 && down[i] > 0) {
            max = (max > up[i] + down[i] + 1) ? max : up[i] + down[i] + 1;
        }
    }

    free(up);
    free(down);
    return max;
}

int minimumRemovals(int* arr, int arrSize) {
    int mountainLength = longestMountain(arr, arrSize);
    return (mountainLength == 0) ? arrSize : arrSize - mountainLength;
}