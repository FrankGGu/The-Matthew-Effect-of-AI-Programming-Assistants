#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minimumRemoval(int* beans, int beansSize){
    qsort(beans, beansSize, sizeof(int), compare);
    long long totalSum = 0;
    for (int i = 0; i < beansSize; i++) {
        totalSum += beans[i];
    }
    long long minRemoval = totalSum;
    for (int i = 0; i < beansSize; i++) {
        long long removal = totalSum - (long long)beans[i] * (beansSize - i);
        if (removal < minRemoval) {
            minRemoval = removal;
        }
    }
    return minRemoval;
}