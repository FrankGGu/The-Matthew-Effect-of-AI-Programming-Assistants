#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* splitString(char* s, int k) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;
    for (int i = 0; i < len; i++) {
        if (i % k == 0 && i != 0) {
            result[index++] = '-';
        }
        result[index++] = s[i];
    }
    result[index] = '\0';
    return result;
}