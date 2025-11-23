#include <stdio.h>
#include <stdlib.h>

int isIdealPermutation(int* A, int ASize) {
    for (int i = 0; i < ASize; i++) {
        if (abs(A[i] - i) > 1) return 0;
    }
    return 1;
}