#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxSatisfaction(int* satisfaction, int satisfactionSize) {
    qsort(satisfaction, satisfactionSize, sizeof(int), cmp);
    int sum = 0;
    int res = 0;
    int current_sum = 0;
    for (int i = satisfactionSize - 1; i >= 0; i--) {
        sum += satisfaction[i];
        if (sum > 0) {
            current_sum += sum;
        } else {
            break;
        }
    }
    return current_sum;
}