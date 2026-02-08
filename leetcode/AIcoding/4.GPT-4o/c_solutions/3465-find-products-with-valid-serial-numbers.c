#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* serial;
} Product;

int isValidSerial(char* serial) {
    int len = strlen(serial);
    if (len != 10) return 0;
    for (int i = 0; i < len; i++) {
        if (!((serial[i] >= '0' && serial[i] <= '9') || (serial[i] >= 'A' && serial[i] <= 'Z'))) {
            return 0;
        }
    }
    return 1;
}

int* findValidProducts(Product* products, int productsSize, int* returnSize) {
    int* validIndices = (int*)malloc(productsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < productsSize; i++) {
        if (isValidSerial(products[i].serial)) {
            validIndices[count++] = i;
        }
    }

    *returnSize = count;
    validIndices = (int*)realloc(validIndices, count * sizeof(int));
    return validIndices;
}