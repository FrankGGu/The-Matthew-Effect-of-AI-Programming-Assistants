#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int reduce(int* satisfaction, int satisfactionSize) {
    qsort(satisfaction, satisfactionSize, sizeof(int), compare);
    int total = 0;
    int sum = 0;
    int result = 0;

    for (int i = satisfactionSize - 1; i >= 0; i--) {
        sum += satisfaction[i];
        if (sum > 0) {
            result += sum;
        } else {
            break;
        }
    }

    return result;
}