#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *convertToBase7(int num) {
    if (num == 0) {
        char *result = (char *)malloc(2 * sizeof(char));
        strcpy(result, "0");
        return result;
    }

    int sign = 1;
    if (num < 0) {
        sign = -1;
        num = -num;
    }

    char buffer[100];
    int index = 0;

    while (num > 0) {
        buffer[index++] = (num % 7) + '0';
        num /= 7;
    }

    if (sign == -1) {
        buffer[index++] = '-';
    }

    buffer[index] = '\0';

    char *result = (char *)malloc((index + 1) * sizeof(char));
    int i, j;
    for (i = 0, j = index - 1; j >= 0; i++, j--) {
        result[i] = buffer[j];
    }
    result[index] = '\0';

    return result;
}