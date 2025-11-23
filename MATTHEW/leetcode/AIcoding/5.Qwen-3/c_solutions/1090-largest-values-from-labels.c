#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int value;
    int label;
} Item;

int compare(const void *a, const void *b) {
    return ((Item *)b)->value - ((Item *)a)->value;
}

int* largestValuesFromLabels(int* values, int valuesSize, int* labels, int labelsSize, int numWanted, int* returnSize) {
    Item *items = (Item *)malloc(valuesSize * sizeof(Item));
    for (int i = 0; i < valuesSize; i++) {
        items[i].value = values[i];
        items[i].label = labels[i];
    }

    qsort(items, valuesSize, sizeof(Item), compare);

    int *result = (int *)malloc(numWanted * sizeof(int));
    int count = 0;
    int labelCount[100000] = {0};

    for (int i = 0; i < valuesSize && count < numWanted; i++) {
        int label = items[i].label;
        if (labelCount[label] < 1) {
            result[count++] = items[i].value;
            labelCount[label]++;
        }
    }

    *returnSize = count;
    free(items);
    return result;
}