#include <stdio.h>
#include <stdlib.h>

int minOperations(int* target, int targetSize) {
    int operations = 0;
    for (int i = 1; i < targetSize; i++) {
        if (target[i] < target[i - 1]) {
            operations += target[i - 1] - target[i];
        }
    }
    return operations;
}