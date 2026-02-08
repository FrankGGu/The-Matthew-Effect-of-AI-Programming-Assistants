#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

char** simplifiedFractions(int n, int* returnSize) {
    char** result = (char**)malloc(n * n * sizeof(char*));
    *returnSize = 0;

    for (int numerator = 1; numerator < n; numerator++) {
        for (int denominator = numerator + 1; denominator <= n; denominator++) {
            if (gcd(numerator, denominator) == 1) {
                char* fraction = (char*)malloc(20 * sizeof(char));
                sprintf(fraction, "%d/%d", numerator, denominator);
                result[(*returnSize)++] = fraction;
            }
        }
    }

    return result;
}