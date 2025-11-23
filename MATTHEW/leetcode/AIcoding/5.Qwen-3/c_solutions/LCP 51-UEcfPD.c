#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* numMovesStones(int* a, int* b, int* c, int* returnSize) {
    int* res = (int*)malloc(2 * sizeof(int));
    int arr[3] = {a[0], b[0], c[0]};
    qsort(arr, 3, sizeof(int), cmp);

    if (arr[2] - arr[0] == 2) {
        res[0] = 0;
    } else if (arr[1] - arr[0] == 1 && arr[2] - arr[1] == 1) {
        res[0] = 0;
    } else {
        res[0] = 1;
    }

    res[1] = arr[2] - arr[0] - 2;
    *returnSize = 2;
    return res;
}