#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Order {
    char *name;
    int table;
};

int cmp(const void *a, const void *b) {
    struct Order *orderA = (struct Order *)a;
    struct Order *orderB = (struct Order *)b;
    if (orderA->table != orderB->table) {
        return orderA->table - orderB->table;
    }
    return strcmp(orderA->name, orderB->name);
}

char **displayTable(char ***orders, int ordersSize, int *returnSize, int **returnColumnSizes) {
    struct Order *orderList = malloc(ordersSize * sizeof(struct Order));
    int tableCount[501] = {0};
    int foodCount = 0;
    char **foodNames = malloc(ordersSize * sizeof(char *));
    int foodIndex = 0;

    for (int i = 0; i < ordersSize; i++) {
        int table = atoi(orders[i][1]);
        char *food = orders[i][2];
        orderList[i].table = table;
        orderList[i].name = food;

        tableCount[table]++;
        int found = 0;
        for (int j = 0; j < foodIndex; j++) {
            if (strcmp(foodNames[j], food) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            foodNames[foodIndex++] = food;
        }
    }

    qsort(orderList, ordersSize, sizeof(struct Order), cmp);
    qsort(foodNames, foodIndex, sizeof(char *), strcmp);

    *returnSize = foodIndex + 1;
    *returnColumnSizes = malloc((*returnSize) * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = (i == 0) ? foodIndex + 1 : ordersSize + 1;
    }

    char **result = malloc((*returnSize) * sizeof(char *));
    result[0] = malloc(100 * sizeof(char));
    strcpy(result[0], "Table");
    for (int i = 0; i < foodIndex; i++) {
        strcat(result[0], ",");
        strcat(result[0], foodNames[i]);
    }

    for (int i = 0; i < foodIndex; i++) {
        result[i + 1] = malloc(100 * sizeof(char));
        snprintf(result[i + 1], 100, "%d", i + 1);
        for (int j = 0; j < foodIndex; j++) {
            int count = 0;
            for (int k = 0; k < ordersSize; k++) {
                if (orderList[k].table == i + 1 && strcmp(orderList[k].name, foodNames[j]) == 0) {
                    count++;
                }
            }
            strcat(result[i + 1], ",");
            char buffer[10];
            snprintf(buffer, sizeof(buffer), "%d", count);
            strcat(result[i + 1], buffer);
        }
    }

    free(orderList);
    free(foodNames);

    return result;
}