#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** verticalWords(char * s, int* returnSize){
    int maxLen = 0;
    int wordCount = 0;
    int i = 0;
    while (s[i] != '\0') {
        int len = 0;
        while (s[i] != ' ' && s[i] != '\0') {
            len++;
            i++;
        }
        if (len > 0) {
            wordCount++;
            if (len > maxLen) {
                maxLen = len;
            }
        }
        if (s[i] == ' ') {
            i++;
        }
    }

    *returnSize = maxLen;
    char **result = (char **)malloc(maxLen * sizeof(char *));
    for (i = 0; i < maxLen; i++) {
        result[i] = (char *)malloc((wordCount + 1) * sizeof(char));
        memset(result[i], ' ', wordCount);
        result[i][wordCount] = '\0';
    }

    i = 0;
    int wordIndex = 0;
    while (s[i] != '\0') {
        int charIndex = 0;
        while (s[i] != ' ' && s[i] != '\0') {
            result[charIndex][wordIndex] = s[i];
            charIndex++;
            i++;
        }
        wordIndex++;
        if (s[i] == ' ') {
            i++;
        }
        if (s[i] == '\0') break;
    }

    return result;
}