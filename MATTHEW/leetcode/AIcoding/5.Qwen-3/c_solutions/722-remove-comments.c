#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeComments(char* source) {
    int len = strlen(source);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int resIndex = 0;
    int i = 0;
    while (i < len) {
        if (i + 1 < len && source[i] == '/' && source[i + 1] == '*') {
            i += 2;
            while (i + 1 < len && !(source[i] == '*' && source[i + 1] == '/')) {
                i++;
            }
            i += 2;
        } else if (i + 1 < len && source[i] == '/' && source[i + 1] == '/') {
            i += 2;
            while (i < len && source[i] != '\n') {
                i++;
            }
        } else {
            result[resIndex++] = source[i++];
        }
    }
    result[resIndex] = '\0';
    return result;
}