#include <stdio.h>
#include <stdlib.h>

int* commonFactors(int* a, int* b, int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int index = 0;

    for (int i = 1; i <= n; i++) {
        int countA = 0;
        int countB = 0;
        for (int j = 0; j < i; j++) {
            if (a[j] == i) countA++;
            if (b[j] == i) countB++;
        }
        if (countA > 0 && countB > 0) {
            result[index++] = i;
        }
    }

    *returnSize = index;
    return result;
}