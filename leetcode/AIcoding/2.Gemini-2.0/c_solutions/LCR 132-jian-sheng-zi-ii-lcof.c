#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* bamboos, int bamboosSize) {
    int sum = 0;
    double avg = 0.0;
    for (int i = 0; i < bamboosSize; i++) {
        sum += bamboos[i];
    }
    avg = (double)sum / bamboosSize;
    if (avg <= 1.0) {
        return 0;
    }

    int operations = 0;
    for (int i = 0; i < bamboosSize; i++) {
        operations += ceil((double)log2(bamboos[i] + 1));
    }
    return operations;
}