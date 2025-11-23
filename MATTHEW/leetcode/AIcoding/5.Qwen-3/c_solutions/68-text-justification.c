#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** fullJustify(char** words, int wordsSize, int maxWidth, int* returnSize) {
    char** result = (char**)malloc(sizeof(char*) * wordsSize);
    *returnSize = 0;
    int i = 0;
    while (i < wordsSize) {
        int j = i;
        int len = 0;
        while (j < wordsSize && len + strlen(words[j]) + (j - i) <= maxWidth) {
            len += strlen(words[j]);
            j++;
        }
        int spaces = maxWidth - len;
        int numWords = j - i;
        char* line = (char*)malloc((maxWidth + 1) * sizeof(char));
        if (numWords == 1) {
            strcpy(line, words[i]);
            for (int k = strlen(line); k < maxWidth; k++) {
                line[k] = ' ';
            }
            line[maxWidth] = '\0';
        } else {
            int totalSpaces = spaces;
            int extraSpaces = totalSpaces % (numWords - 1);
            int baseSpaces = totalSpaces / (numWords - 1);
            for (int k = 0; k < numWords - 1; k++) {
                strcat(line, words[i + k]);
                for (int l = 0; l < baseSpaces; l++) {
                    strcat(line, " ");
                }
                if (extraSpaces > 0) {
                    strcat(line, " ");
                    extraSpaces--;
                }
            }
            strcat(line, words[j - 1]);
        }
        result[*returnSize] = line;
        (*returnSize)++;
        i = j;
    }
    return result;
}