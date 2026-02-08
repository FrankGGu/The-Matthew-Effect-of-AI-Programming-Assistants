#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * makeFancyString(char * s){
    int len = strlen(s);
    if (len <= 2) {
        return s;
    }

    int newLen = 0;
    char* result = (char*)malloc((len + 1) * sizeof(char));

    for (int i = 0; i < len; i++) {
        if (newLen >= 2 && result[newLen - 1] == s[i] && result[newLen - 2] == s[i]) {
            continue;
        }
        result[newLen++] = s[i];
    }

    result[newLen] = '\0';
    return result;
}