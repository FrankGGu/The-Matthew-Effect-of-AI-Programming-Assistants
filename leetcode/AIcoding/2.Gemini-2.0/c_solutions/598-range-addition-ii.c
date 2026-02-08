#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCount(int m, int n, int** ops, int opsSize, int* opsColSize) {
    int min_a = m;
    int min_b = n;

    for (int i = 0; i < opsSize; i++) {
        if (ops[i][0] < min_a) {
            min_a = ops[i][0];
        }
        if (ops[i][1] < min_b) {
            min_b = ops[i][1];
        }
    }

    return min_a * min_b;
}