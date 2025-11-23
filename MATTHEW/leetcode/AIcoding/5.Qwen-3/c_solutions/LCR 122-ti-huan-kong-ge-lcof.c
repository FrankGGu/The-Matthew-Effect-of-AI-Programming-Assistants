#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* pathEncryption(char* path) {
    int len = strlen(path);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;
    for (int i = 0; i < len; i++) {
        if (path[i] == '/') {
            result[index++] = '\\';
        } else {
            result[index++] = path[i];
        }
    }
    result[index] = '\0';
    return result;
}