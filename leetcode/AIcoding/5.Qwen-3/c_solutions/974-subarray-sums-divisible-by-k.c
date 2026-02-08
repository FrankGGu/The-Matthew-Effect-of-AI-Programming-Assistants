#include <stdio.h>
#include <stdlib.h>

int subarraysDivByK(int* A, int ASize, int K) {
    int* prefixMod = (int*)calloc(K, sizeof(int));
    prefixMod[0] = 1;
    int currentSum = 0;
    int count = 0;

    for (int i = 0; i < ASize; i++) {
        currentSum += A[i];
        int mod = currentSum % K;
        if (mod < 0) mod += K;
        count += prefixMod[mod];
        prefixMod[mod]++;
    }

    free(prefixMod);
    return count;
}