#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool canArrange(int* arr, int arrSize, int k) {
    int* count = (int*)calloc(k, sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        int rem = arr[i] % k;
        if (rem < 0) rem += k;
        count[rem]++;
    }

    if (count[0] % 2 != 0) return false;

    for (int i = 1; i < k / 2 + 1; i++) {
        if (count[i] != count[k - i]) return false;
    }

    free(count);
    return true;
}