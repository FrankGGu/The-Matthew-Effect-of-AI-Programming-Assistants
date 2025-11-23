#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* decrypt(char* s, int key) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    for (int i = 0; i < len; i++) {
        result[i] = s[i] - key;
    }
    result[len] = '\0';
    return result;
}