#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findProducts(char** serialNumbers, int serialNumbersSize, int* returnSize) {
    char** result = (char**)malloc(serialNumbersSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < serialNumbersSize; i++) {
        char* s = serialNumbers[i];
        int len = strlen(s);
        int valid = 1;

        for (int j = 0; j < len; j++) {
            if (j % 2 == 0) {
                if (s[j] < 'A' || s[j] > 'Z') {
                    valid = 0;
                    break;
                }
            } else {
                if (s[j] < '0' || s[j] > '9') {
                    valid = 0;
                    break;
                }
            }
        }

        if (valid) {
            result[*returnSize] = (char*)malloc((len + 1) * sizeof(char));
            strcpy(result[*returnSize], s);
            (*returnSize)++;
        }
    }

    return result;
}