/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maximumBeauty(int** items, int itemsSize, int* itemsColSize, int* queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));

    // Sort items by price
    for (int i = 0; i < itemsSize - 1; i++) {
        for (int j = 0; j < itemsSize - i - 1; j++) {
            if (items[j][0] > items[j + 1][0]) {
                int temp_price = items[j][0];
                int temp_beauty = items[j][1];
                items[j][0] = items[j + 1][0];
                items[j][1] = items[j + 1][1];
                items[j + 1][0] = temp_price;
                items[j + 1][1] = temp_beauty;
            }
        }
    }

    // Create array to store max beauty up to each price
    int* maxBeauty = (int*)malloc(itemsSize * sizeof(int));
    maxBeauty[0] = items[0][1];
    for (int i = 1; i < itemsSize; i++) {
        maxBeauty[i] = items[i][1] > maxBeauty[i - 1] ? items[i][1] : maxBeauty[i - 1];
    }

    // Process each query
    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int left = 0, right = itemsSize - 1;
        int best = 0;

        // Binary search for the highest price <= query
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (items[mid][0] <= query) {
                best = maxBeauty[mid];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        result[i] = best;
    }

    free(maxBeauty);
    return result;
}