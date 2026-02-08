#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findThePrefixCommonArray(int* A, int ASize, int* B, int BSize, int* returnSize) {
    int* result = (int*)malloc(ASize * sizeof(int));
    *returnSize = ASize;
    int count = 0;
    int seen[51] = {0};

    for (int i = 0; i < ASize; i++) {
        int current_count = 0;
        int seen_local[51] = {0};

        for (int j = 0; j <= i; j++) {
            if (seen_local[A[j]] == 0) {
                seen_local[A[j]] = 1;
            }
        }

        for (int j = 0; j <= i; j++) {
            if (seen_local[B[j]] == 1) {
                current_count++;
            }
        }
        result[i] = current_count;
    }

    return result;
}