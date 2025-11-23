#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minimumCost(int* satisfaction, int satisfactionSize) {
    qsort(satisfaction, satisfactionSize, sizeof(int), cmpfunc);
    int total = 0;
    int sum = 0;
    for (int i = satisfactionSize - 1; i >= 0; i--) {
        if (sum + satisfaction[i] > 0) {
            sum += satisfaction[i];
            total += sum;
        } else {
            break;
        }
    }
    return total;
}