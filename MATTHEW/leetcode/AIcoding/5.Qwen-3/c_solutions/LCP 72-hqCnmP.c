#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int capacity;
    int weight;
    int value;
} Item;

int compare(const void *a, const void *b) {
    Item *itemA = (Item *)a;
    Item *itemB = (Item *)b;
    return (itemB->value * itemA->weight) - (itemA->value * itemB->weight);
}

int bag(int capacity, int* weights, int* values, int n) {
    Item *items = (Item *)malloc(n * sizeof(Item));
    for (int i = 0; i < n; i++) {
        items[i].capacity = 1;
        items[i].weight = weights[i];
        items[i].value = values[i];
    }
    qsort(items, n, sizeof(Item), compare);

    int totalValue = 0;
    for (int i = 0; i < n && capacity > 0; i++) {
        if (items[i].weight <= capacity) {
            totalValue += items[i].value;
            capacity -= items[i].weight;
        } else {
            totalValue += (items[i].value * capacity) / items[i].weight;
            capacity = 0;
        }
    }
    free(items);
    return totalValue;
}