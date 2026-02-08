#include <stdio.h>
#include <stdlib.h>

int minImpossibleOR(int* A, int ASize) {
    int result = 1;
    int* seen = (int*)calloc(32, sizeof(int));

    for (int i = 0; i < ASize; i++) {
        seen[A[i]] = 1;
    }

    while (seen[result]) {
        result++;
    }

    free(seen);
    return result;
}