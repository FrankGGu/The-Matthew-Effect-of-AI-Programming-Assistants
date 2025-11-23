#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* sortVowels(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int vowelCount = 0;
    int i, j;

    for (i = 0; i < len; i++) {
        char c = s[i];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
            c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') {
            result[vowelCount++] = c;
        }
    }

    for (i = 0; i < len; i++) {
        char c = s[i];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
            c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') {
            result[i] = result[--vowelCount];
        } else {
            result[i] = c;
        }
    }

    result[len] = '\0';
    return result;
}