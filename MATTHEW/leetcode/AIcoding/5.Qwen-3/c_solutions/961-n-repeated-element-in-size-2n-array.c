#include <stdio.h>
#include <stdlib.h>

int repeatedNTimes(int* A, int ASize) {
    int seen[10000] = {0};
    for (int i = 0; i < ASize; i++) {
        if (seen[A[i]] == 1) {
            return A[i];
        }
        seen[A[i]] = 1;
    }
    return -1;
}