#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletionSize(char **A, int ASize, int *AColSize) {
    int count = 0;
    for (int j = 0; j < *AColSize; j++) {
        for (int i = 1; i < ASize; i++) {
            if (A[i][j] < A[i-1][j]) {
                count++;
                break;
            }
        }
    }
    return count;
}