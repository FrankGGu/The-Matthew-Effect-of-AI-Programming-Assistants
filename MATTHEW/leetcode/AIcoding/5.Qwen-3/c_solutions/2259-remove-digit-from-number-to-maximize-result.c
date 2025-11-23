#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeDigit(char* number, char digit) {
    int n = strlen(number);
    int index = -1;

    for (int i = 0; i < n; i++) {
        if (number[i] == digit) {
            index = i;
            if (i < n - 1 && number[i + 1] > number[i]) {
                break;
            }
        }
    }

    char* result = (char*)malloc(n * sizeof(char));
    int j = 0;

    for (int i = 0; i < n; i++) {
        if (i != index) {
            result[j++] = number[i];
        }
    }

    result[j] = '\0';
    return result;
}