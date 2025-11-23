#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reverseWords(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int resultIndex = 0;
    int wordStart = -1;

    for (int i = len - 1; i >= 0; i--) {
        if (s[i] == ' ') {
            if (wordStart != -1) {
                for (int j = wordStart; j > i; j--) {
                    result[resultIndex++] = s[j];
                }
                result[resultIndex++] = ' ';
                wordStart = -1;
            }
        } else {
            if (wordStart == -1) {
                wordStart = i;
            }
        }
    }

    if (wordStart != -1) {
        for (int j = wordStart; j >= 0; j--) {
            result[resultIndex++] = s[j];
        }
    }

    result[resultIndex] = '\0';
    return result;
}