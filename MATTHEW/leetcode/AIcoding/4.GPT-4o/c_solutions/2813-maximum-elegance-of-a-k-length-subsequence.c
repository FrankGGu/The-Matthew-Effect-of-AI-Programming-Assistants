#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int value;
    int index;
} Item;

int cmp(const void *a, const void *b) {
    return ((Item *)b)->value - ((Item *)a)->value;
}

long long maxElegance(int* nums, int numsSize, int k) {
    Item* items = (Item*)malloc(numsSize * sizeof(Item));
    for (int i = 0; i < numsSize; i++) {
        items[i].value = nums[i];
        items[i].index = i;
    }

    qsort(items, numsSize, sizeof(Item), cmp);

    long long elegance = 0;
    int distinctCount = 0;
    int* used = (int*)calloc(numsSize, sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count < k) {
            elegance += items[i].value;
            if (!used[items[i].index]) {
                distinctCount++;
                used[items[i].index] = 1;
            }
            count++;
        } else {
            break;
        }
    }

    elegance += (long long)distinctCount * distinctCount;

    free(items);
    free(used);
    return elegance;
}