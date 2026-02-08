#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeColoredPieces(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (i > 0 && i < len - 1 && s[i - 1] == s[i + 1]) {
            continue;
        }
        result[index++] = s[i];
    }

    result[index] = '\0';
    return result;
}