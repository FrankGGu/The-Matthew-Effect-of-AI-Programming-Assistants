#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reverseWords(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;
    int wordStart = -1;

    for (int i = 0; i <= len; i++) {
        if (s[i] == ' ' || s[i] == '\0') {
            if (wordStart != -1) {
                for (int j = i - 1; j >= wordStart; j--) {
                    result[index++] = s[j];
                }
                result[index++] = ' ';
                wordStart = -1;
            }
        } else {
            if (wordStart == -1) {
                wordStart = i;
            }
        }
    }

    if (index > 0) {
        index--;
    }
    result[index] = '\0';
    return result;
}