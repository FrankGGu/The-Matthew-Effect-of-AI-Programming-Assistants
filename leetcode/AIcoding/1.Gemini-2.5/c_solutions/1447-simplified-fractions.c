#include <stdlib.h>
#include <stdio.h>

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

char** simplifiedFractions(int n, int* returnSize) {
    char** result = (char**)malloc(sizeof(char*) * (n * n));
    *returnSize = 0;

    for (int d = 2; d <= n; d++) {
        for (int num = 1; num < d; num++) {
            if (gcd(num, d) == 1) {
                char* fractionStr = (char*)malloc(sizeof(char) * 8);
                sprintf(fractionStr, "%d/%d", num, d);
                result[*returnSize] = fractionStr;
                (*returnSize)++;
            }
        }
    }

    return result;
}