#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long* sumOfThree(long long num, int* returnSize){
    if (num % 3 != 0) {
        *returnSize = 0;
        return NULL;
    }

    long long middle = num / 3;
    long long* result = (long long*)malloc(sizeof(long long) * 3);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    result[0] = middle - 1;
    result[1] = middle;
    result[2] = middle + 1;

    *returnSize = 3;
    return result;
}