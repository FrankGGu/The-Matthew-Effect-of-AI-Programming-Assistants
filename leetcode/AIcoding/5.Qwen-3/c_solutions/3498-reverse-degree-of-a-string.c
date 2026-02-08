#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reverseDegreeOfString(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = len - 1; i >= 0; i--) {
        result[index++] = s[i];
    }
    result[index] = '\0';
    return result;
}