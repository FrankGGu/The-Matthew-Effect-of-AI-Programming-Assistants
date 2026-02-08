#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int beauty;
    int weight;
} Item;

int cmp(const void *a, const void *b) {
    Item *itemA = (Item *)a;
    Item *itemB = (Item *)b;
    if (itemA->beauty != itemB->beauty) {
        return itemB->beauty - itemA->beauty;
    }
    return itemA->weight - itemB->weight;
}

int* mostBeautifulItem(int* weights, int weightsSize, int* beauties, int beautiesSize, int* queries, int queriesSize, int* returnSize) {
    Item *items = (Item *)malloc(weightsSize * sizeof(Item));
    for (int i = 0; i < weightsSize; i++) {
        items[i].beauty = beauties[i];
        items[i].weight = weights[i];
    }

    qsort(items, weightsSize, sizeof(Item), cmp);

    int *result = (int *)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int maxWeight = queries[i];
        int maxBeauty = 0;
        for (int j = 0; j < weightsSize; j++) {
            if (items[j].weight <= maxWeight) {
                maxBeauty = items[j].beauty;
                break;
            }
        }
        result[i] = maxBeauty;
    }

    free(items);
    *returnSize = queriesSize;
    return result;
}