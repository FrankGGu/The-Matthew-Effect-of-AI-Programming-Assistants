#include <stdio.h>
#include <stdlib.h>

int findChildrenWithBall(int n, int k) {
    int* arr = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = i + 1;
    }
    int current = 0;
    for (int i = 1; i <= k; i++) {
        if (i % 2 == 1) {
            current = (current + 1) % n;
        } else {
            current = (current - 1 + n) % n;
        }
    }
    int result = arr[current];
    free(arr);
    return result;
}