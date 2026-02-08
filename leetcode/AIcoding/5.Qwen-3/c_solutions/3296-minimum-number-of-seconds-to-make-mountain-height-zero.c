#include <stdio.h>
#include <stdlib.h>

int* getMinimumSeconds(int** a, int n, int* m) {
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        int max_val = 0;
        for (int j = 0; j < n; j++) {
            if (a[i][j] > max_val) {
                max_val = a[i][j];
            }
        }
        result[i] = max_val;
    }
    *m = n;
    return result;
}