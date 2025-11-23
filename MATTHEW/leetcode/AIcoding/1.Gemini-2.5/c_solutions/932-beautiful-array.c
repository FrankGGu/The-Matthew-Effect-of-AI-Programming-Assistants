#include <stdlib.h>

int* beautifulArray(int n, int* returnSize) {
    if (n == 1) {
        int* arr = (int*)malloc(sizeof(int));
        arr[0] = 1;
        *returnSize = 1;
        return arr;
    }

    int leftSize;
    int* left = beautifulArray((n + 1) / 2, &leftSize);

    int rightSize;
    int* right = beautifulArray(n / 2, &rightSize);

    int* result = (int*)malloc(sizeof(int) * n);
    int k = 0;

    for (int i = 0; i < leftSize; ++i) {
        result[k++] = 2 * left[i] - 1;
    }

    for (int i = 0; i < rightSize; ++i) {
        result[k++] = 2 * right[i];
    }

    *returnSize = n;

    free(left);
    free(right);

    return result;
}