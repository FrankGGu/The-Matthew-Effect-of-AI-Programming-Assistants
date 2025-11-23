#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int** findSimplifiedFractions(int n, int* returnSize, int** returnColumnSizes) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j < i; j++) {
            if (gcd(i, j) == 1) {
                count++;
            }
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int index = 0;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j < i; j++) {
            if (gcd(i, j) == 1) {
                result[index] = (int*)malloc(2 * sizeof(int));
                result[index][0] = j;
                result[index][1] = i;
                (*returnColumnSizes)[index] = 2;
                index++;
            }
        }
    }

    return result;
}