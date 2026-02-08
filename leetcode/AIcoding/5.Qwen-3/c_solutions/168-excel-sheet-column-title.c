#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* convertToTitle(int columnNumber) {
    char* result = (char*)malloc(26 * sizeof(char));
    int index = 0;
    while (columnNumber > 0) {
        columnNumber--;
        result[index++] = 'A' + (columnNumber % 26);
        columnNumber /= 26;
    }
    result[index] = '\0';
    for (int i = 0; i < index / 2; i++) {
        char temp = result[i];
        result[i] = result[index - i - 1];
        result[index - i - 1] = temp;
    }
    return result;
}