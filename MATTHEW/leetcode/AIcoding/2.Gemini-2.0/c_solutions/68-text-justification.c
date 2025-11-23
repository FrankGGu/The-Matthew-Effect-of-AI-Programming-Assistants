#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** fullJustify(char ** words, int wordsSize, int maxWidth, int* returnSize){
    char **result = (char **)malloc(sizeof(char *) * wordsSize);
    *returnSize = 0;
    int i = 0;
    while (i < wordsSize) {
        int j = i;
        int len = 0;
        while (j < wordsSize && len + strlen(words[j]) + (j - i) <= maxWidth) {
            len += strlen(words[j]);
            j++;
        }

        char *line = (char *)malloc(sizeof(char) * (maxWidth + 1));
        int numWords = j - i;
        int numSpaces = maxWidth - len;

        if (numWords == 1 || j == wordsSize) {
            int k = 0;
            for (int l = i; l < j; l++) {
                strcpy(line + k, words[l]);
                k += strlen(words[l]);
                if (l < j - 1) {
                    line[k++] = ' ';
                }
            }
            while (k < maxWidth) {
                line[k++] = ' ';
            }
            line[k] = '\0';
        } else {
            int spacesBetween = numSpaces / (numWords - 1);
            int extraSpaces = numSpaces % (numWords - 1);
            int k = 0;
            for (int l = i; l < j; l++) {
                strcpy(line + k, words[l]);
                k += strlen(words[l]);
                if (l < j - 1) {
                    for (int m = 0; m < spacesBetween; m++) {
                        line[k++] = ' ';
                    }
                    if (extraSpaces > 0) {
                        line[k++] = ' ';
                        extraSpaces--;
                    }
                }
            }
            line[k] = '\0';
        }

        result[*returnSize] = line;
        (*returnSize)++;
        i = j;
    }
    return result;
}