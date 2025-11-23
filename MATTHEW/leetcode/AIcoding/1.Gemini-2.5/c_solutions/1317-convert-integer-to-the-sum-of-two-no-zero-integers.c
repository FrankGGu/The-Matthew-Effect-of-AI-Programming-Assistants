#include <stdlib.h>

int hasZero(int num) {
    while (num > 0) {
        if (num % 10 == 0) {
            return 1;
        }
        num /= 10;
    }
    return 0;
}

int* getNoZeroIntegers(int n, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(sizeof(int) * 2);

    for (int a = 1; a < n; a++) {
        int b = n - a;
        if (!hasZero(a) && !hasZero(b)) {
            result[0] = a;
            result[1] = b;
            return result;
        }
    }
    return NULL;
}