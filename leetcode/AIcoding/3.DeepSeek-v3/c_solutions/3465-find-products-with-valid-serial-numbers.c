#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

bool isValidSerialNumber(const char* serial) {
    int len = strlen(serial);
    if (len < 11 || len > 15) return false;

    // Check if all characters are alphanumeric
    for (int i = 0; i < len; i++) {
        if (!isalnum(serial[i])) return false;
    }

    // Check if it contains at least one digit and one letter
    bool hasDigit = false, hasLetter = false;
    for (int i = 0; i < len; i++) {
        if (isdigit(serial[i])) hasDigit = true;
        if (isalpha(serial[i])) hasLetter = true;
    }
    if (!hasDigit || !hasLetter) return false;

    // Check if it doesn't contain any of the forbidden substrings
    const char* forbidden[] = {"000", "111", "222", "333", "444", 
                              "555", "666", "777", "888", "999"};
    for (int i = 0; i < 10; i++) {
        if (strstr(serial, forbidden[i]) != NULL) return false;
    }

    // Check if it doesn't contain "123" or "abc"
    if (strstr(serial, "123") != NULL || strstr(serial, "abc") != NULL) return false;

    return true;
}

char** findValidSerialNumbers(char** products, int productsSize, int* returnSize) {
    char** result = (char**)malloc(productsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < productsSize; i++) {
        if (isValidSerialNumber(products[i])) {
            result[*returnSize] = (char*)malloc((strlen(products[i]) + 1) * sizeof(char));
            strcpy(result[*returnSize], products[i]);
            (*returnSize)++;
        }
    }

    return result;
}