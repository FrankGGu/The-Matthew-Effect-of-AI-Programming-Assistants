#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    int *ia = (int *)a;
    int *ib = (int *)b;
    return ia[0] - ib[0];
}

int* maximumBeauty(int** items, int itemsSize, int* itemsColSize, int* queries, int queriesSize, int* returnSize) {
    qsort(items, itemsSize, sizeof(items[0]), compare);

    int maxBeauty = 0;
    for (int i = 0; i < itemsSize; i++) {
        if (items[i][1] > maxBeauty) {
            maxBeauty = items[i][1];
        } else {
            items[i][1] = maxBeauty;
        }
    }

    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int left = 0;
        int right = itemsSize - 1;
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (items[mid][0] <= query) {
                ans = items[mid][1];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result[i] = ans;
    }

    return result;
}