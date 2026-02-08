#include <stdio.h>
#include <stdlib.h>

long long int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int sumSubseqWidths(int* A, int ASize) {
    qsort(A, ASize, sizeof(int), compare);
    long long int result = 0;
    long long int power[ASize];
    power[0] = 1;
    for (int i = 1; i < ASize; i++) {
        power[i] = (power[i - 1] * 2) % 1000000007;
    }
    for (int i = 0; i < ASize; i++) {
        result = (result + (long long int)A[i] * (power[i] - power[ASize - 1 - i])) % 1000000007;
    }
    return (int)result;
}