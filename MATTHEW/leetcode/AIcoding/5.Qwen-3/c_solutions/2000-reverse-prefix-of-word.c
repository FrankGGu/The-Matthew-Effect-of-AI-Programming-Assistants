#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reversePrefix(char* word, char ch) {
    int len = strlen(word);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int i, j;

    for (i = 0; i < len; i++) {
        if (word[i] == ch) {
            break;
        }
    }

    if (i == len) {
        strcpy(result, word);
        return result;
    }

    for (j = 0; j <= i; j++) {
        result[j] = word[i - j];
    }

    for (j = i + 1; j < len; j++) {
        result[j] = word[j];
    }

    result[len] = '\0';
    return result;
}