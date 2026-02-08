#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_PRODUCTS 100
#define MAX_NAME_LENGTH 50

typedef struct {
    char name[MAX_NAME_LENGTH];
    int spring;
    int summer;
    int autumn;
    int winter;
} Product;

int compareSales(const void* a, const void* b) {
    Product* p1 = (Product*)a;
    Product* p2 = (Product*)b;
    int total1 = p1->spring + p1->summer + p1->autumn + p1->winter;
    int total2 = p2->spring + p2->summer + p2->autumn + p2->winter;
    if (total1 != total2) {
        return total2 - total1;
    }
    return strcmp(p1->name, p2->name);
}

char** mostProfitableProducts(char*** productSales, int productSalesSize, int* productSalesColSize, int* returnSize) {
    Product products[MAX_PRODUCTS];

    for (int i = 0; i < productSalesSize; i++) {
        strcpy(products[i].name, productSales[i][0]);
        products[i].spring = atoi(productSales[i][1]);
        products[i].summer = atoi(productSales[i][2]);
        products[i].autumn = atoi(productSales[i][3]);
        products[i].winter = atoi(productSales[i][4]);
    }

    qsort(products, productSalesSize, sizeof(Product), compareSales);

    int count = (productSalesSize + 2) / 3;
    char** result = (char**)malloc(count * sizeof(char*));

    for (int i = 0; i < count; i++) {
        result[i] = (char*)malloc((strlen(products[i].name) + 1) * sizeof(char));
        strcpy(result[i], products[i].name);
    }

    *returnSize = count;
    return result;
}