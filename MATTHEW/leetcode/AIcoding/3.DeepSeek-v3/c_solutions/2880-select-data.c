#include <stdio.h>
#include <stdlib.h>

char** selectData(char*** products, int productsSize, int* productsColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = productsSize;
    *returnColumnSizes = (int*)malloc(productsSize * sizeof(int));
    for (int i = 0; i < productsSize; i++) {
        (*returnColumnSizes)[i] = 3;
    }

    char** result = (char**)malloc(productsSize * sizeof(char*));
    for (int i = 0; i < productsSize; i++) {
        result[i] = (char*)malloc(100 * sizeof(char));
        snprintf(result[i], 100, "{\"name\":\"%s\",\"price\":\"%s\",\"year\":\"%s\"}", 
                products[i][0], products[i][1], products[i][2]);
    }

    return result;
}