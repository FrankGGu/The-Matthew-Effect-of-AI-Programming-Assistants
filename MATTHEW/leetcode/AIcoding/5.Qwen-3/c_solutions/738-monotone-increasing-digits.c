#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* monotoneIncrDigits(char* n) {
    int len = strlen(n);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strcpy(result, n);

    int i = 0;
    while (i < len - 1 && result[i] <= result[i + 1]) {
        i++;
    }

    if (i == len - 1) {
        return result;
    }

    while (i >= 0 && result[i] > result[i + 1]) {
        result[i]--;
        i--;
    }

    i++;
    while (i < len) {
        result[i] = '9';
        i++;
    }

    return result;
}