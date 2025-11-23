#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* convertToBase7(int num) {
    if (num == 0) {
        char* result = (char*)malloc(2 * sizeof(char));
        strcpy(result, "0");
        return result;
    }

    int isNegative = 0;
    if (num < 0) {
        isNegative = 1;
        num = -num;
    }

    char buffer[32];
    int index = 0;

    while (num > 0) {
        buffer[index++] = (num % 7) + '0';
        num /= 7;
    }

    if (isNegative) {
        buffer[index++] = '-';
    }

    char* result = (char*)malloc((index + 1) * sizeof(char));
    for (int i = 0; i < index; i++) {
        result[i] = buffer[index - 1 - i];
    }
    result[index] = '\0';

    return result;
}