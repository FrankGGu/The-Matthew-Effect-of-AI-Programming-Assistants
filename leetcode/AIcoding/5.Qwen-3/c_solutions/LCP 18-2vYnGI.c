#include <stdio.h>
#include <stdlib.h>

int* breakfastGame(int* costs, int costsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;
    int min1 = INT_MAX, min2 = INT_MAX;
    for (int i = 0; i < costsSize; i++) {
        if (costs[i] < min1) {
            min2 = min1;
            min1 = costs[i];
        } else if (costs[i] < min2) {
            min2 = costs[i];
        }
    }
    result[0] = min1;
    result[1] = min2;
    return result;
}