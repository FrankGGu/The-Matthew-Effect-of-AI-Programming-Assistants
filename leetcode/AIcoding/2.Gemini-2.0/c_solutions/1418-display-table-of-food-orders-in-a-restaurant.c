#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** table;
    int row;
    int col;
} Result;

int compare_str(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

int compare_int(const void* a, const void* b) {
    return atoi(*(const char**)a) - atoi(*(const char**)b);
}

char*** displayTable(char*** orders, int ordersSize, int* ordersColSize, int* returnSize, int** returnColumnSizes) {
    // 1. Find unique food items and table numbers
    char** food_items = NULL;
    int food_count = 0;
    char** tables = NULL;
    int table_count = 0;

    for (int i = 0; i < ordersSize; i++) {
        char* food = orders[i][2];
        int found = 0;
        for (int j = 0; j < food_count; j++) {
            if (strcmp(food_items[j], food) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            food_items = (char**)realloc(food_items, (food_count + 1) * sizeof(char*));
            food_items[food_count] = strdup(food);
            food_count++;
        }

        char* table = orders[i][1];
        found = 0;
        for (int j = 0; j < table_count; j++) {
            if (strcmp(tables[j], table) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            tables = (char**)realloc(tables, (table_count + 1) * sizeof(char*));
            tables[table_count] = strdup(table);
            table_count++;
        }
    }

    // 2. Sort food items and table numbers
    qsort(food_items, food_count, sizeof(char*), compare_str);
    qsort(tables, table_count, sizeof(char*), compare_int);

    // 3. Create the result table
    char*** result_table = (char***)malloc((table_count + 1) * sizeof(char**));
    *returnColumnSizes = (int*)malloc((table_count + 1) * sizeof(int));
    *returnSize = table_count + 1;

    for (int i = 0; i < table_count + 1; i++) {
        result_table[i] = (char**)malloc((food_count + 1) * sizeof(char*));
        (*returnColumnSizes)[i] = food_count + 1;
    }

    // 4. Fill in the header row
    result_table[0][0] = strdup("Table");
    for (int i = 0; i < food_count; i++) {
        result_table[0][i + 1] = strdup(food_items[i]);
    }

    // 5. Fill in the table data
    for (int i = 0; i < table_count; i++) {
        result_table[i + 1][0] = strdup(tables[i]);
        for (int j = 0; j < food_count; j++) {
            int count = 0;
            for (int k = 0; k < ordersSize; k++) {
                if (strcmp(orders[k][1], tables[i]) == 0 && strcmp(orders[k][2], food_items[j]) == 0) {
                    count++;
                }
            }
            char count_str[10];
            sprintf(count_str, "%d", count);
            result_table[i + 1][j + 1] = strdup(count_str);
        }
    }

    // 6. Free memory for food_items and tables
    for (int i = 0; i < food_count; i++) {
        free(food_items[i]);
    }
    free(food_items);
    for (int i = 0; i < table_count; i++) {
        free(tables[i]);
    }
    free(tables);

    return result_table;
}