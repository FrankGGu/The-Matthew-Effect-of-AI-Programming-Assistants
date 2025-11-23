#include <stdlib.h>
#include <string.h>
#include <stdio.h> // For sprintf, atoi

typedef struct {
    char* name;
} FoodItem;

int cmp_food_items(const void* a, const void* b) {
    return strcmp(((FoodItem*)a)->name, ((FoodItem*)b)->name);
}

int cmp_food_item_name_to_struct(const void* key, const void* elem) {
    return strcmp((char*)key, ((FoodItem*)elem)->name);
}

typedef struct {
    int num;
} TableNum;

int cmp_table_nums(const void* a, const void* b) {
    return ((TableNum*)a)->num - ((TableNum*)b)->num;
}

int cmp_table_num_to_struct(const void* key, const void* elem) {
    return *(int*)key - ((TableNum*)elem)->num;
}

typedef struct {
    int tableNum;
    char* foodName; // strdup'd
} OrderEntry;

int cmp_order_entries(const void* a, const void* b) {
    OrderEntry* oa = (OrderEntry*)a;
    OrderEntry* ob = (OrderEntry*)b;
    if (oa->tableNum != ob->tableNum) {
        return oa->tableNum - ob->tableNum;
    }
    return strcmp(oa->foodName, ob->foodName);
}

typedef struct {
    int tableNum;
    char* foodName; // strdup'd
    int count;
} AggregatedCount;

#define INITIAL_CAPACITY 1000

typedef struct {
    char** items;
    int size;
    int capacity;
} CharArray;

void init_char_array(CharArray* arr) {
    arr->items = (char**)malloc(INITIAL_CAPACITY * sizeof(char*));
    arr->size = 0;
    arr->capacity = INITIAL_CAPACITY;
}

void add_char_array(CharArray* arr, char* item) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->items = (char**)realloc(arr->items, arr->capacity * sizeof(char*));
    }
    arr->items[arr->size++] = item;
}

typedef struct {
    int* items;
    int size;
    int capacity;
} IntArray;

void init_int_array(IntArray* arr) {
    arr->items = (int*)malloc(INITIAL_CAPACITY * sizeof(int));
    arr->size = 0;
    arr->capacity = INITIAL_CAPACITY;
}

void add_int_array(IntArray* arr, int item) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->items = (int*)realloc(arr->items, arr->capacity * sizeof(int));
    }
    arr->items[arr->size++] = item;
}

typedef struct {
    OrderEntry* items;
    int size;
    int capacity;
} OrderEntryArray;

void init_order_entry_array(OrderEntryArray* arr) {
    arr->items = (OrderEntry*)malloc(INITIAL_CAPACITY * sizeof(OrderEntry));
    arr->size = 0;
    arr->capacity = INITIAL_CAPACITY;
}

void add_order_entry_array(OrderEntryArray* arr, OrderEntry item) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->items = (OrderEntry*)realloc(arr->items, arr->capacity * sizeof(OrderEntry));
    }
    arr->items[arr->size++] = item;
}

#define MAX_UNIQUE_FOOD_ITEMS 501  // Max 500 unique food items
#define MAX_UNIQUE_TABLE_NUMS 1001 // Max 1000 unique table numbers
#define MAX_AGGREGATED_COUNTS 500001 // Max 1000 tables * 500 food items = 500,000

char*** displayTable(char*** orders, int ordersSize, int* ordersColSize, int* returnSize, int** returnColumnSizes) {
    // 1. Raw collection of food names, table numbers, and order entries
    CharArray raw_food_names;
    init_char_array(&raw_food_names);

    IntArray raw_table_nums;
    init_int_array(&raw_table_nums);

    OrderEntryArray raw_order_entries;
    init_order_entry_array(&raw_order_entries);

    for (int i = 0; i < ordersSize; ++i) {
        int tableNum = atoi(orders[i][1]);
        char* foodName_for_entry = strdup(orders[i][2]); // For OrderEntry
        char* foodName_for_unique = strdup(orders[i][2]); // For unique food items list

        add_char_array(&raw_food_names, foodName_for_unique);
        add_int_array(&raw_table_nums, tableNum);

        OrderEntry entry = { .tableNum = tableNum, .foodName = foodName_for_entry };
        add_order_entry_array(&raw_order_entries, entry);
    }

    // 2. Process unique food items
    // Move char* pointers from raw_food_names to a temporary array for sorting
    char** all_food_names_temp = (char**)malloc(raw_food_names.size * sizeof(char*));
    for(int i = 0; i < raw_food_names.size; ++i) {
        all_food_names_temp[i] = raw_food_names.items[i];
    }
    free(raw_food_names.items); // Free the array of pointers itself

    // Sort all food names
    qsort(all_food_names_temp, raw_food_names.size, sizeof(char*), (int (*)(const void*, const void*))strcmp);

    FoodItem unique_food_items[MAX_UNIQUE_FOOD_ITEMS];
    int num_unique_food_items = 0;
    if (raw_food_names.size > 0) {
        unique_food_items[num_unique_food_items++].name = all_food_names_temp[0]; // Take ownership of the first string
        for (int i = 1; i < raw_food_names.size; ++i) {
            if (strcmp(all_food_names_temp[i], unique_food_items[num_unique_food_items - 1].name) != 0) {
                unique_food_items[num_unique_food_items++].name = all_food_names_temp[i]; // Take ownership of new unique string
            } else {
                free(all_food_names_temp[i]); // Free duplicate string
            }
        }
    }
    free(all_food_names_temp); // Free the temporary array of pointers

    // 3. Process unique table numbers
    // Convert raw_table_nums to TableNum array for sorting
    TableNum* table_nums_for_sort = (TableNum*)malloc(raw_table_nums.size * sizeof(TableNum));
    for (int i = 0; i < raw_table_nums.size; ++i) {
        table_nums_for_sort[i].num = raw_table_nums.items[i];
    }
    free(raw_table_nums.items); // Free the array of ints itself

    // Sort table numbers
    qsort(table_nums_for_sort, raw_table_nums.size, sizeof(TableNum), cmp_table_nums);

    TableNum unique_table_nums[MAX_UNIQUE_TABLE_NUMS];
    int num_unique_tables = 0;
    if (raw_table_nums.size > 0) {
        unique_table_nums[num_unique_tables++].num = table_nums_for_sort[0].num;
        for (int i = 1; i < raw_table_nums.size; ++i) {
            if (table_nums_for_sort[i].num != unique_table_nums[num_unique_tables - 1].num) {
                unique_table_nums[num_unique_tables++].num = table_nums_for_sort[i].num;
            }
        }
    }
    free(table_nums_for_sort); // Free the temporary array of TableNum structs

    // 4. Aggregate counts from raw_order_entries
    qsort(raw_order_entries.items, raw_order_entries.size, sizeof(OrderEntry), cmp_order_entries);

    AggregatedCount aggregated_counts[MAX_AGGREGATED_COUNTS];
    int num_aggregated_counts = 0;

    if (raw_order_entries.size > 0) {
        aggregated_counts[num_aggregated_counts].tableNum = raw_order_entries.items[0].tableNum;
        aggregated_counts[num_aggregated_counts].foodName = raw_order_entries.items[0].foodName; // Take ownership
        aggregated_counts[num_aggregated_counts].count = 1;
        num_aggregated_counts++;

        for (int i = 1; i < raw_order_entries.size; ++i) {
            if (raw_order_entries.items[i].tableNum == aggregated_counts[num_aggregated_counts - 1].tableNum &&
                strcmp(raw_order_entries.items[i].foodName, aggregated_counts[num_aggregated_counts - 1].foodName) == 0) {
                aggregated_counts[num_aggregated_counts - 1].count++;
                free(raw_order_entries.items[i].foodName); // Free duplicate foodName string
            } else {
                aggregated_counts[num_aggregated_counts].tableNum = raw_order_entries.items[i].tableNum;
                aggregated_counts[num_aggregated_counts].foodName = raw_order_entries.items[i].foodName; // Take ownership
                aggregated_counts[num_aggregated_counts].count = 1;
                num_aggregated_counts++;
            }
        }
    }
    free(raw_order_entries.items); // Free the array of OrderEntry structs itself

    // 5. Populate final_counts_matrix (2D array of ints)
    int** final_counts_matrix = (int**)calloc(num_unique_tables, sizeof(int*));
    for (int i = 0; i < num_unique_tables; ++i) {
        final_counts_matrix[i] = (int*)calloc(num_unique_food_items, sizeof(int));
    }

    for (int k = 0; k < num_aggregated_counts; ++k) {
        int target_table_num = aggregated_counts[k].tableNum;
        char* target_food_name = aggregated_counts[k].foodName;

        TableNum* found_table = (TableNum*)bsearch(&target_table_num, unique_table_nums, num_unique_tables, sizeof(TableNum), cmp_table_num_to_struct);
        int table_idx = found_table - unique_table_nums;

        FoodItem* found_food = (FoodItem*)bsearch(target_food_name, unique_food_items, num_unique_food_items, sizeof(FoodItem), cmp_food_item_name_to_struct);
        int food_idx = found_food - unique_food_items;

        final_counts_matrix[table_idx][food_idx] = aggregated_counts[k].count;
        free(aggregated_counts[k].foodName); // Free the foodName string from aggregated_counts
    }

    // 6. Construct final char*** result table
    *returnSize = num_unique_tables + 1;
    *returnColumnSizes = (int*)malloc((*returnSize) * sizeof(int));
    char*** result = (char***)malloc((*returnSize) * sizeof(char**));

    // Header row
    (*returnColumnSizes)[0] = num_unique_food_items + 1;
    result[0] = (char**)malloc((*returnColumnSizes)[0] * sizeof(char*));
    result[0][0] = strdup("Table");
    for (int j = 0; j < num_unique_food_items; ++j) {
        result[0][j+1] = strdup(unique_food_items[j].name);
    }

    // Data rows
    for (int i = 0; i < num_unique_tables; ++i) {
        (*returnColumnSizes)[i+1] = num_unique_food_items + 1;
        result[i+1] = (char**)malloc((*returnColumnSizes)[i+1] * sizeof(char*));

        // Table number column
        char table_num_str[10]; // Max table number 1000, 4 digits + null. 10 is safe.
        sprintf(table_num_str, "%d", unique_table_nums[i].num);
        result[i+1][0] = strdup(table_num_str);

        // Food counts columns
        for (int j = 0; j < num_unique_food_items; ++j) {
            char count_str[10]; // Max count can be ordersSize (500000), 6 digits + null. 10 is safe.
            sprintf(count_str, "%d", final_counts_matrix[i][j]);
            result[i+1][j+1] = strdup(count_str);
        }
    }

    // 7. Cleanup intermediate memory
    for (int i = 0; i < num_unique_food_items; ++i) {
        free(unique_food_items[i].name); // Free strings from unique_food_items
    }

    for (int i = 0; i < num_unique_tables; ++i) {
        free(final_counts_matrix[i]);
    }
    free(final_counts_matrix);

    return result;
}