#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long gcd(long long a, long long b) {
    while (b) {
        long long temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int* fraction(int cont[], int contSize, int* returnSize) {
    long long numerator = 1;
    long long denominator = cont[contSize - 1];

    for (int i = contSize - 2; i >= 0; i--) {
        long long temp = denominator;
        denominator = cont[i] * denominator + numerator;
        numerator = temp;
    }

    long long common = gcd(numerator, denominator);
    numerator /= common;
    denominator /= common;

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = denominator;
    result[1] = numerator;

    *returnSize = 2;
    return result;
}