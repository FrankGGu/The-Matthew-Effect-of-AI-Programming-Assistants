#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxIceCream(int* costs, int costsSize, int coins) {
    qsort(costs, costsSize, sizeof(int), compare);
    int count = 0;
    for (int i = 0; i < costsSize && coins >= costs[i]; i++) {
        coins -= costs[i];
        count++;
    }
    return count;
}