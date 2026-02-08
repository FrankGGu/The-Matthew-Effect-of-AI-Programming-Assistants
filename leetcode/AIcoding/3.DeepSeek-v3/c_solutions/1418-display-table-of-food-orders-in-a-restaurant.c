#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* food;
    int count;
} FoodCount;

typedef struct {
    int tableNumber;
    FoodCount* foods;
    int foodSize;
    int foodCapacity;
} Table;

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

int compareTables(const void* a, const void* b) {
    return ((Table*)a)->tableNumber - ((Table*)b)->tableNumber;
}

char*** displayTable(char*** orders, int ordersSize, int* ordersColSize, int* returnSize, int** returnColumnSizes) {
    char** allFoods = malloc(ordersSize * sizeof(char*));
    int allFoodsSize = 0;

    Table* tables = malloc(ordersSize * sizeof(Table));
    int tablesSize = 0;

    for (int i = 0; i < ordersSize; i++) {
        char* tableStr = orders[i][1];
        char* food = orders[i][2];

        int tableNumber = atoi(tableStr);

        int tableIndex = -1;
        for (int j = 0; j < tablesSize; j++) {
            if (tables[j].tableNumber == tableNumber) {
                tableIndex = j;
                break;
            }
        }

        if (tableIndex == -1) {
            tableIndex = tablesSize;
            tables[tableIndex].tableNumber = tableNumber;
            tables[tableIndex].foods = malloc(ordersSize * sizeof(FoodCount));
            tables[tableIndex].foodSize = 0;
            tables[tableIndex].foodCapacity = ordersSize;
            tablesSize++;
        }

        Table* table = &tables[tableIndex];
        int foodIndex = -1;
        for (int j = 0; j < table->foodSize; j++) {
            if (strcmp(table->foods[j].food, food) == 0) {
                foodIndex = j;
                break;
            }
        }

        if (foodIndex == -1) {
            foodIndex = table->foodSize;
            table->foods[foodIndex].food = food;
            table->foods[foodIndex].count = 0;
            table->foodSize++;
        }

        table->foods[foodIndex].count++;

        int found = 0;
        for (int j = 0; j < allFoodsSize; j++) {
            if (strcmp(allFoods[j], food) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            allFoods[allFoodsSize++] = food;
        }
    }

    qsort(allFoods, allFoodsSize, sizeof(char*), compareStrings);
    qsort(tables, tablesSize, sizeof(Table), compareTables);

    int numRows = tablesSize + 1;
    int numCols = allFoodsSize + 1;

    char*** result = malloc(numRows * sizeof(char**));
    *returnColumnSizes = malloc(numRows * sizeof(int));

    for (int i = 0; i < numRows; i++) {
        result[i] = malloc(numCols * sizeof(char*));
        (*returnColumnSizes)[i] = numCols;
    }

    result[0][0] = "Table";
    for (int j = 0; j < allFoodsSize; j++) {
        result[0][j + 1] = allFoods[j];
    }

    for (int i = 0; i < tablesSize; i++) {
        char tableNumStr[10];
        sprintf(tableNumStr, "%d", tables[i].tableNumber);
        result[i + 1][0] = strdup(tableNumStr);

        for (int j = 0; j < allFoodsSize; j++) {
            char* food = allFoods[j];
            int count = 0;

            for (int k = 0; k < tables[i].foodSize; k++) {
                if (strcmp(tables[i].foods[k].food, food) == 0) {
                    count = tables[i].foods[k].count;
                    break;
                }
            }

            char countStr[10];
            sprintf(countStr, "%d", count);
            result[i + 1][j + 1] = strdup(countStr);
        }
    }

    *returnSize = numRows;

    free(allFoods);
    for (int i = 0; i < tablesSize; i++) {
        free(tables[i].foods);
    }
    free(tables);

    return result;
}