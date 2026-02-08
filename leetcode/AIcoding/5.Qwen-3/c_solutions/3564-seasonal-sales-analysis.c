#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* product_id;
    char* sale_date;
    int price;
} Sales;

int compare(const void* a, const void* b) {
    Sales* sa = (Sales*)a;
    Sales* sb = (Sales*)b;
    return strcmp(sa->sale_date, sb->sale_date);
}

int** seasonalSalesAnalysis(char** sales_data, int sales_dataSize, int* returnSize, int** returnColumnSizes) {
    Sales* sales = (Sales*)malloc(sales_dataSize * sizeof(Sales));
    for (int i = 0; i < sales_dataSize; i++) {
        char* token = strtok(sales_data[i], ",");
        sales[i].product_id = (char*)malloc(strlen(token) + 1);
        strcpy(sales[i].product_id, token);
        token = strtok(NULL, ",");
        sales[i].sale_date = (char*)malloc(strlen(token) + 1);
        strcpy(sales[i].sale_date, token);
        token = strtok(NULL, ",");
        sales[i].price = atoi(token);
    }

    qsort(sales, sales_dataSize, sizeof(Sales), compare);

    int** result = (int**)malloc(sales_dataSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(sales_dataSize * sizeof(int));
    *returnSize = 0;

    int current_month = -1;
    int total_sales = 0;
    int count = 0;

    for (int i = 0; i < sales_dataSize; i++) {
        int month = atoi(sales[i].sale_date + 5);
        if (month != current_month) {
            if (current_month != -1) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = current_month;
                result[*returnSize][1] = total_sales / count;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
            current_month = month;
            total_sales = sales[i].price;
            count = 1;
        } else {
            total_sales += sales[i].price;
            count++;
        }
    }

    if (current_month != -1) {
        result[*returnSize] = (int*)malloc(2 * sizeof(int));
        result[*returnSize][0] = current_month;
        result[*returnSize][1] = total_sales / count;
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;
    }

    for (int i = 0; i < sales_dataSize; i++) {
        free(sales[i].product_id);
        free(sales[i].sale_date);
    }
    free(sales);

    return result;
}