#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* minimumTimeToBrewPotions(int* potions, int potionsSize, int k, int* returnSize) {
    qsort(potions, potionsSize, sizeof(int), compare);
    int* result = (int*)malloc(k * sizeof(int));
    *returnSize = k;
    for (int i = 0; i < k; i++) {
        result[i] = 0;
    }
    for (int i = 0; i < potionsSize; i++) {
        int minIndex = 0;
        for (int j = 1; j < k; j++) {
            if (result[j] < result[minIndex]) {
                minIndex = j;
            }
        }
        result[minIndex] += potions[i];
    }
    return result;
}