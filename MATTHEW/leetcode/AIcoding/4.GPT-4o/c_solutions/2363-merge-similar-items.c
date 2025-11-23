#include <stdlib.h>

typedef struct {
    int value;
    int weight;
} Item;

int cmp(const void *a, const void *b) {
    return ((Item *)a)->value - ((Item *)b)->value;
}

int** mergeSimilarItems(int** items1, int items1Size, int* items1ColSize, 
                        int** items2, int items2Size, int* items2ColSize, 
                        int* returnSize, int** returnColumnSizes) {
    int maxSize = items1Size + items2Size;
    Item *merged = (Item *)malloc(maxSize * sizeof(Item));
    int count = 0;

    for (int i = 0; i < items1Size; i++) {
        merged[count].value = items1[i][0];
        merged[count].weight = items1[i][1];
        count++;
    }

    for (int i = 0; i < items2Size; i++) {
        int found = 0;
        for (int j = 0; j < count; j++) {
            if (merged[j].value == items2[i][0]) {
                merged[j].weight += items2[i][1];
                found = 1;
                break;
            }
        }
        if (!found) {
            merged[count].value = items2[i][0];
            merged[count].weight = items2[i][1];
            count++;
        }
    }

    qsort(merged, count, sizeof(Item), cmp);

    int **result = (int **)malloc(count * sizeof(int *));
    *returnColumnSizes = (int *)malloc(count * sizeof(int));
    *returnSize = count;

    for (int i = 0; i < count; i++) {
        result[i] = (int *)malloc(2 * sizeof(int));
        result[i][0] = merged[i].value;
        result[i][1] = merged[i].weight;
    }

    free(merged);
    return result;
}