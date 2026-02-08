#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getNoZeroIntegers(int n, int* returnSize) {
    int a = 1;
    while ((n - a) % 10 == 0 || (n - a) / 10 == 0) {
        a++;
    }
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = a;
    result[1] = n - a;
    *returnSize = 2;
    return result;
}