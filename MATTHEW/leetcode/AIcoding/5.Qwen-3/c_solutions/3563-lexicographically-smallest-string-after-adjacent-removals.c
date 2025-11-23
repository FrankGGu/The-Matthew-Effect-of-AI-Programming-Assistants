#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* lexSmallestString(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i++) {
        while (index > 0 && s[i] < result[index - 1]) {
            index--;
        }
        result[index++] = s[i];
    }

    result[index] = '\0';
    return result;
}