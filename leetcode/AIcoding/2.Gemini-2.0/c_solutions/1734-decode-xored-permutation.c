#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* decode(int* encoded, int encodedSize, int n, int* returnSize){
    int* perm = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int xor_sum = 0;
    for (int i = 1; i <= n; i++) {
        xor_sum ^= i;
    }

    int encoded_xor_sum = 0;
    for (int i = 1; i < encodedSize; i += 2) {
        encoded_xor_sum ^= encoded[i];
    }

    perm[0] = xor_sum ^ encoded_xor_sum;

    for (int i = 1; i < n; i++) {
        perm[i] = perm[i - 1] ^ encoded[i - 1];
    }

    return perm;
}