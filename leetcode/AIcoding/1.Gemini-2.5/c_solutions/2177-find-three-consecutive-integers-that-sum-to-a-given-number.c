#include <stdlib.h>

long long* sumOfThree(long long num, int* returnSize) {
    if (num % 3 == 0) {
        long long x = num / 3;
        long long* result = (long long*)malloc(sizeof(long long) * 3);
        result[0] = x - 1;
        result[1] = x;
        result[2] = x + 1;
        *returnSize = 3;
        return result;
    } else {
        *returnSize = 0;
        return NULL;
    }
}