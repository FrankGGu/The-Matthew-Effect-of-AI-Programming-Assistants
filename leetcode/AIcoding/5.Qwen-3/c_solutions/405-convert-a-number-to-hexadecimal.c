#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* toHex(int num) {
    if (num == 0) {
        char* result = (char*)malloc(2 * sizeof(char));
        strcpy(result, "0");
        return result;
    }

    char* hexDigits = "0123456789abcdef";
    char* result = (char*)malloc(9 * sizeof(char));
    int index = 0;

    while (num != 0 && index < 8) {
        int remainder = num & 15;
        result[index++] = hexDigits[remainder];
        num >>= 4;
    }

    result[index] = '\0';
    char* reversed = (char*)malloc(9 * sizeof(char));
    for (int i = 0; i < index; i++) {
        reversed[i] = result[index - 1 - i];
    }
    reversed[index] = '\0';

    free(result);
    return reversed;
}