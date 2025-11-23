#include <stdio.h>
#include <stdlib.h>

int* decode(int* encoded, int encodedSize, int* returnSize) {
    int n = encodedSize + 1;
    int total_xor = 0;
    for (int i = 1; i <= n; i++) {
        total_xor ^= i;
    }

    int first = 0;
    for (int i = 1; i < encodedSize; i += 2) {
        first ^= encoded[i];
    }

    int* result = (int*)malloc(n * sizeof(int));
    result[0] = first;
    for (int i = 1; i < n; i++) {
        result[i] = result[i - 1] ^ encoded[i - 1];
    }

    *returnSize = n;
    return result;
}