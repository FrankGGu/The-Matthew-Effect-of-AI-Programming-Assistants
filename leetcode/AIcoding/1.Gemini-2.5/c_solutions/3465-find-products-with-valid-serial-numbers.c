#include <stdlib.h>
#include <string.h>
#include <ctype.h>

struct Product {
    int id;
    char *serialNumber;
};

int isValidSerialNumber(const char* serial) {
    if (serial == NULL) {
        return 0;
    }

    int len = strlen(serial);

    if (len != 11) {
        return 0;
    }

    if (strncmp(serial, "SN-", 3) != 0) {
        return 0;
    }

    for (int i = 3; i < 7; i++) {
        if (!isdigit(serial[i])) {
            return 0;
        }
    }

    if (serial[7] != '-') {
        return 0;
    }

    for (int i = 8; i < 11; i++) {
        if (!isupper(serial[i])) {
            return 0;
        }
    }

    return 1;
}

struct Product* findProductsWithValidSerialNumbers(struct Product* products, int productsSize, int* returnSize) {
    if (products == NULL || productsSize <= 0) {
        *returnSize = 0;
        return NULL;
    }

    struct Product* validProductsTemp = (struct Product*)malloc(productsSize * sizeof(struct Product));
    if (validProductsTemp == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    for (int i = 0; i < productsSize; i++) {
        if (isValidSerialNumber(products[i].serialNumber)) {
            validProductsTemp[count].id = products[i].id;
            validProductsTemp[count].serialNumber = strdup(products[i].serialNumber);
            if (validProductsTemp[count].serialNumber == NULL) {
                for (int j = 0; j < count; j++) {
                    free(validProductsTemp[j].serialNumber);
                }
                free(validProductsTemp);
                *returnSize = 0;
                return NULL;
            }
            count++;
        }
    }

    struct Product* result = (struct Product*)malloc(count * sizeof(struct Product));
    if (result == NULL) {
        for (int i = 0; i < count; i++) {
            free(validProductsTemp[i].serialNumber);
        }
        free(validProductsTemp);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < count; i++) {
        result[i] = validProductsTemp[i];
    }

    free(validProductsTemp);

    *returnSize = count;
    return result;
}