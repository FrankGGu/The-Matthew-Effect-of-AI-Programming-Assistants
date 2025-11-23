#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* makeFancyString(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;
    int count = 1;

    for (int i = 0; i < len; i++) {
        if (i > 0 && s[i] == s[i - 1]) {
            count++;
        } else {
            count = 1;
        }

        if (count < 3) {
            result[index++] = s[i];
        }
    }

    result[index] = '\0';
    return result;
}