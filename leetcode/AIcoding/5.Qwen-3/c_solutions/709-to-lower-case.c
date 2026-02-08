#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

char* toLowerCase(char* s) {
    char* result = (char*)malloc(strlen(s) + 1);
    for (int i = 0; s[i]; i++) {
        result[i] = tolower(s[i]);
    }
    result[strlen(s)] = '\0';
    return result;
}