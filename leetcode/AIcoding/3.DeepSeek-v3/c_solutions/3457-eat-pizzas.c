#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

long long maxWeight(int* weights, int weightsSize) {
    qsort(weights, weightsSize, sizeof(int), cmp);

    long long sum = 0;
    int n = weightsSize;
    int days = (n + 1) / 2;

    for (int i = 0; i < days; i++) {
        sum += weights[i * 2];
    }

    return sum;
}