#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* productQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int powers[31];
    int powersSize = 0;
    for (int i = 0; i < 31; i++) {
        if (n & (1 << i)) {
            powers[powersSize++] = 1 << i;
        }
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        long long product = 1;
        for (int j = left; j <= right; j++) {
            product = (product * powers[j]) % 1000000007;
        }
        result[i] = (int)product;
    }

    return result;
}