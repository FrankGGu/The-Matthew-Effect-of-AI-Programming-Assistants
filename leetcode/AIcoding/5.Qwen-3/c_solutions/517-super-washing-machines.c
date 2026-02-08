#include <stdio.h>
#include <stdlib.h>

int* findWashingMachines(int* machines, int machinesSize, int* returnSize) {
    *returnSize = machinesSize;
    int* result = (int*)malloc(machinesSize * sizeof(int));
    int total = 0;
    for (int i = 0; i < machinesSize; i++) {
        total += machines[i];
    }
    int avg = total / machinesSize;
    int balance = 0;
    for (int i = 0; i < machinesSize; i++) {
        balance += machines[i] - avg;
        result[i] = abs(balance);
    }
    return result;
}