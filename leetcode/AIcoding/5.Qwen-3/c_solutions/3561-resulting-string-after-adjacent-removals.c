#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeAdjacentDuplicates(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top >= 0 && result[top] == s[i]) {
            top--;
        } else {
            result[++top] = s[i];
        }
    }

    result[++top] = '\0';
    return result;
}