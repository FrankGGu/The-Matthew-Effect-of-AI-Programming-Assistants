#include <stdio.h>
#include <stdlib.h>

long long int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long int removeMinimumMagicBeans(int* beans, int beansSize) {
    qsort(beans, beansSize, sizeof(int), compare);
    long long int total = 0;
    for (int i = 0; i < beansSize; i++) {
        total += beans[i];
    }
    long long int min = total;
    for (int i = 0; i < beansSize; i++) {
        long long int current = (long long)beans[i] * (beansSize - i);
        if (current < min) {
            min = current;
        }
    }
    return min;
}