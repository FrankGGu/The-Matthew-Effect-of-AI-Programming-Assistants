#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minNumberOperations(int* target, int targetSize) {
    int operations = 0;
    int prev = 0;
    for (int i = 0; i < targetSize; i++) {
        if (target[i] > prev) {
            operations += target[i] - prev;
        }
        prev = target[i];
    }
    return operations;
}