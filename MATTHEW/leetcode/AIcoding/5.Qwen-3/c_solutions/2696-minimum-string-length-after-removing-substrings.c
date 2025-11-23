#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minLengthAfterRemovals(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top >= 0 && ((s[i] == 'a' && s[top] == 'b') || (s[i] == 'b' && s[top] == 'a'))) {
            top--;
        } else {
            result[++top] = s[i];
        }
    }

    result[top + 1] = '\0';
    return result;
}