#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

long long maxRunTime(int n, int* batteries, int batteriesSize) {
    qsort(batteries, batteriesSize, sizeof(int), cmp);
    long long sum = 0;
    for (int i = 0; i < batteriesSize; i++) {
        sum += batteries[i];
    }
    int k = 0;
    while (k < batteriesSize && batteries[batteriesSize - 1 - k] > sum / (n - k)) {
        sum -= batteries[batteriesSize - 1 - k];
        k++;
    }
    return sum / (n - k);
}