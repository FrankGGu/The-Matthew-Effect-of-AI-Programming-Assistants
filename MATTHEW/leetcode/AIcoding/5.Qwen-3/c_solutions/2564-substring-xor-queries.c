#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* substringXOR(int* s, int sSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = sSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int idx = 0;

    for (int i = 0; i < queriesSize; i++) {
        int x = queries[i][0];
        int y = queries[i][1];
        int target = x ^ y;
        int found = -1;

        for (int j = 0; j < n; j++) {
            int xor = 0;
            for (int k = j; k < n; k++) {
                xor ^= (s[k] == '1' ? 1 : 0);
                if (xor == target) {
                    found = k + 1;
                    break;
                }
            }
            if (found != -1) break;
        }

        result[idx++] = found;
    }

    *returnSize = queriesSize;
    return result;
}