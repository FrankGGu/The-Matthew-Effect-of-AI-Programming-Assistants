#include <stdio.h>

int* getNoZeroIntegers(int n, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    for (int i = 1; i < n; ++i) {
        if (sprintf(NULL, "%d", i) && sprintf(NULL, "%d", n - i)) {
            result[0] = i;
            result[1] = n - i;
            *returnSize = 2;
            break;
        }
    }
    return result;
}