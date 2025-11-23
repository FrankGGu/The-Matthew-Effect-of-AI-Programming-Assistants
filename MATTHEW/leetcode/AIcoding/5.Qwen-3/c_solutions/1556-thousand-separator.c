#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* thousandSeparator(int n) {
    char* result = (char*)malloc(100 * sizeof(char));
    int index = 0;
    int count = 0;

    if (n == 0) {
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    while (n > 0) {
        if (count > 0 && count % 3 == 0) {
            result[index++] = '.';
        }
        result[index++] = '0' + (n % 10);
        n /= 10;
        count++;
    }

    result[index] = '\0';
    int len = strlen(result);
    for (int i = 0; i < len / 2; i++) {
        char temp = result[i];
        result[i] = result[len - 1 - i];
        result[len - 1 - i] = temp;
    }

    return result;
}