#include <stdlib.h> // For malloc, qsort

typedef struct {
    int price;
    int original_index;
} QueryInfo;

int compareItems(const void* a, const void* b) {
    // a and b are pointers to int* (rows of items)
    int* itemA = *(int**)a;
    int* itemB = *(int**)b;
    return itemA[0] - itemB[0]; // Sort by price (first element of the item array)
}

int compareQueryInfo(const void* a, const void* b) {
    // a and b are pointers to QueryInfo structs
    QueryInfo* qa = (QueryInfo*)a;
    QueryInfo* qb = (QueryInfo*)b;
    return qa->price - qb->price; // Sort by query price
}

int* mostBeautifulItem(int** items, int itemsSize, int* itemsColSize, int* queries, int queriesSize, int* returnSize) {
    // 1. Allocate memory for the result array
    int* results = (int*)malloc(queriesSize * sizeof(int));
    if (results == NULL) {
        *returnSize = 0;
        return NULL; // Handle allocation failure
    }
    *returnSize = queriesSize;

    // 2. Sort items by price
    // This allows us to process items in increasing order of price
    qsort(items, itemsSize, sizeof(int*), compareItems);

    // 3. Create an array of QueryInfo structs to store queries with their original indices
    // This is necessary to return results in the original query order after sorting queries
    QueryInfo* query_infos = (QueryInfo*)malloc(queriesSize * sizeof(QueryInfo));
    if (query_infos == NULL) {
        free(results);
        *returnSize = 0;
        return NULL; // Handle allocation failure
    }

    for (int i = 0; i < queriesSize; ++i) {
        query_infos[i].price = queries[i];
        query_infos[i].original_index = i;
    }

    // 4. Sort query_infos by query price
    // This allows us to process queries in increasing order of price,
    // which pairs well with the sorted items array using a two-pointer approach.
    qsort(query_infos, queriesSize, sizeof(QueryInfo), compareQueryInfo);

    // 5. Use a two-pointer approach to process queries efficiently
    int item_ptr = 0;
    int current_max_beauty_overall = 0; // Stores the maximum beauty encountered so far for valid items

    for (int i = 0; i < queriesSize; ++i) {
        int current_query_price = query_infos[i].price;
        int original_query_index = query_infos[i].original_index;

        // Advance item_ptr as long as item price is less than or equal to the current query price
        // For each such item, update the current_max_beauty_overall
        while (item_ptr < itemsSize && items[item_ptr][0] <= current_query_price) {
            if (items[item_ptr][1] > current_max_beauty_overall) {
                current_max_beauty_overall = items[item_ptr][1];
            }
            item_ptr++;
        }

        // The current_max_beauty_overall now holds the maximum beauty for all items
        // with price <= current_query_price. Store this in the results array
        // at the original index of the query.
        results[original_query_index] = current_max_beauty_overall;
    }

    // 6. Free the temporary query_infos array
    free(query_infos);

    return results;
}