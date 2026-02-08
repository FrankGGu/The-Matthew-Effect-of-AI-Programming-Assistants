#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

long long maxRunTime(int* batteries, int batteriesSize) {
    qsort(batteries, batteriesSize, sizeof(int), compare);
    long long total = 0;
    for (int i = 0; i < batteriesSize; ++i) {
        total += batteries[i];
    }
    int n = batteriesSize;
    long long ans = 0;
    for (int i = 0; i < batteriesSize; ++i) {
        if (batteries[i] > ans) {
            ans++;
            total -= batteries[i];
        } else {
            break;
        }
    }
    return total / n + ans;
}