#include <stdlib.h> // For qsort, malloc, free
#include <string.h> // For memset (optional, can loop to init)

typedef struct {
    int value;
    int label;
} Item;

int compareItems(const void *a, const void *b) {
    return ((Item *)b)->value - ((Item *)a)->value;
}

int largestValsFromLabels(int* values, int valuesSize, int* labels, int labelsSize, int numWanted, int useLimit) {
    // Create an array of Item structs to pair values and labels
    Item* items = (Item*)malloc(sizeof(Item) * valuesSize);

    for (int i = 0; i < valuesSize; ++i) {
        items[i].value = values[i];
        items[i].label = labels[i];
    }

    // Sort items by value in descending order
    qsort(items, valuesSize, sizeof(Item), compareItems);

    // Array to keep track of how many times each label has been used.
    // Max label value is 2 * 10^4, so an array of size 20001 is sufficient.
    // Labels are non-negative.
    int label_counts[20001] = {0}; // Initialize all counts to 0

    int current_sum = 0;
    int items_selected = 0;

    // Iterate through sorted items and select greedily
    for (int i = 0; i < valuesSize && items_selected < numWanted; ++i) {
        int current_label = items[i].label;

        // Check if we can still use an item with this label based on useLimit
        if (label_counts[current_label] < useLimit) {
            current_sum += items[i].value;
            label_counts[current_label]++;
            items_selected++;
        }
    }

    // Free the dynamically allocated memory
    free(items);

    return current_sum;
}