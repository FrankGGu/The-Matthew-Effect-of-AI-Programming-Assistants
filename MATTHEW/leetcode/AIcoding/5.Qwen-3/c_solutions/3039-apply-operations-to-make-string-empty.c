#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* applyOperations(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') {
            result[index++] = 'a';
        } else if (s[i] == 'b') {
            result[index++] = 'b';
        } else if (s[i] == 'c') {
            if (index > 0 && result[index - 1] == 'b') {
                result[index - 1] = 'c';
            } else {
                result[index++] = 'c';
            }
        }
    }

    result[index] = '\0';
    return result;
}