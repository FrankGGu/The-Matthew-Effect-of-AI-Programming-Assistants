#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* maximumOddBinaryNumber(char* s) {
    int count0 = 0;
    int count1 = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '0') count0++;
        else count1++;
    }
    char* result = (char*)malloc((strlen(s) + 1) * sizeof(char));
    int idx = 0;
    for (int i = 0; i < count1 - 1; i++) {
        result[idx++] = '1';
    }
    for (int i = 0; i < count0; i++) {
        result[idx++] = '0';
    }
    result[idx++] = '1';
    result[idx] = '\0';
    return result;
}