#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeStars(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '*') {
            if (index > 0) {
                index--;
            }
        } else {
            result[index++] = s[i];
        }
    }

    result[index] = '\0';
    return result;
}