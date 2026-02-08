#include <stdlib.h>

int* decode(int* encoded, int encodedSize, int* returnSize) {
    int n = encodedSize + 1;
    *returnSize = n;

    int* perm = (int*)malloc(n * sizeof(int));
    if (perm == NULL) {
        return NULL;
    }

    int total_xor = 0;
    for (int i = 1; i <= n; i++) {
        total_xor ^= i;
    }

    int xor_of_all_but_p0 = 0;
    for (int i = 1; i < encodedSize; i += 2) {
        xor_of_all_but_p0 ^= encoded[i];
    }

    perm[0] = total_xor ^ xor_of_all_but_p0;

    for (int i = 0; i < encodedSize; i++) {
        perm[i+1] = perm[i] ^ encoded[i];
    }

    return perm;
}