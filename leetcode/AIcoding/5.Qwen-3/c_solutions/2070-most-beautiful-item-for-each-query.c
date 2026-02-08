#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int price;
    int beauty;
} Item;

int compare(const void *a, const void *b) {
    return ((Item *)a)->price - ((Item *)b)->price;
}

int* maximumBeauty(int** items, int itemsSize, int* itemsColSize, int* queries, int queriesSize, int* returnSize) {
    qsort(items, itemsSize, sizeof(Item), compare);

    int* maxBeauty = (int*)malloc(queriesSize * sizeof(int));
    int* prefixMax = (int*)malloc(itemsSize * sizeof(int));

    prefixMax[0] = items[0]->beauty;
    for (int i = 1; i < itemsSize; i++) {
        prefixMax[i] = (prefixMax[i - 1] > items[i]->beauty) ? prefixMax[i - 1] : items[i]->beauty;
    }

    for (int i = 0; i < queriesSize; i++) {
        int low = 0, high = itemsSize - 1;
        int best = -1;
        while (low <= high) {
            int mid = (low + high) / 2;
            if (items[mid]->price <= queries[i]) {
                best = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        if (best != -1) {
            maxBeauty[i] = prefixMax[best];
        } else {
            maxBeauty[i] = 0;
        }
    }

    *returnSize = queriesSize;
    free(prefixMax);
    return maxBeauty;
}