#include <stdio.h>
#include <stdlib.h>

int getMaximumGenerated(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    int* arr = (int*)malloc(n * sizeof(int));
    arr[0] = 0;
    arr[1] = 1;
    int max = 1;

    for (int i = 2; i < n; i++) {
        if (i % 2 == 0) {
            arr[i] = arr[i / 2];
        } else {
            arr[i] = arr[i / 2] + arr[i / 2 + 1];
        }
        if (arr[i] > max) {
            max = arr[i];
        }
    }

    free(arr);
    return max;
}