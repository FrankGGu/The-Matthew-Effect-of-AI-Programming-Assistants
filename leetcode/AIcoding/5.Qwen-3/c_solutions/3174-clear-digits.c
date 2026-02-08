#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* clearDigits(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int resultIndex = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            int count = s[i] - '0';
            while (count > 0 && resultIndex > 0) {
                resultIndex--;
                count--;
            }
        } else {
            result[resultIndex++] = s[i];
        }
    }

    result[resultIndex] = '\0';
    return result;
}