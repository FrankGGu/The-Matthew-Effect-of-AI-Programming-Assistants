#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

char ** simplifiedFractions(int n, int* returnSize){
    if (n <= 1) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    for (int i = 2; i <= n; i++) {
        for (int j = 1; j < i; j++) {
            if (gcd(i, j) == 1) {
                count++;
            }
        }
    }

    char **result = (char **)malloc(count * sizeof(char *));
    *returnSize = 0;

    for (int i = 2; i <= n; i++) {
        for (int j = 1; j < i; j++) {
            if (gcd(i, j) == 1) {
                char *fraction = (char *)malloc(10 * sizeof(char));
                sprintf(fraction, "%d/%d", j, i);
                result[*returnSize] = fraction;
                (*returnSize)++;
            }
        }
    }

    return result;
}