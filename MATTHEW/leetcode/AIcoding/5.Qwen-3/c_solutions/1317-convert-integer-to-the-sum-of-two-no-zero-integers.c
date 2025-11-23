#include <stdio.h>
#include <stdlib.h>

int* getNoZeroIntegers(int n, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    for (int a = 1; a < n; a++) {
        int b = n - a;
        int aCopy = a;
        int bCopy = b;
        int hasZeroA = 0;
        int hasZeroB = 0;
        while (aCopy > 0) {
            if (aCopy % 10 == 0) {
                hasZeroA = 1;
                break;
            }
            aCopy /= 10;
        }
        while (bCopy > 0) {
            if (bCopy % 10 == 0) {
                hasZeroB = 1;
                break;
            }
            bCopy /= 10;
        }
        if (!hasZeroA && !hasZeroB) {
            result[0] = a;
            result[1] = b;
            *returnSize = 2;
            return result;
        }
    }
    *returnSize = 0;
    return NULL;
}