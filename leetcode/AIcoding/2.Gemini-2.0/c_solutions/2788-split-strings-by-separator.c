#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STRINGS 100
#define MAX_STRING_LENGTH 20

char **splitWordsBySeparator(char **words, int wordsSize, char separator, int *returnSize) {
    char **result = (char **)malloc(MAX_STRINGS * sizeof(char *));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int wordLength = strlen(word);
        int start = 0;

        for (int j = 0; j <= wordLength; j++) {
            if (j == wordLength || word[j] == separator) {
                if (j > start) {
                    char *newWord = (char *)malloc((j - start + 1) * sizeof(char));
                    strncpy(newWord, word + start, j - start);
                    newWord[j - start] = '\0';
                    result[*returnSize] = newWord;
                    (*returnSize)++;
                }
                start = j + 1;
            }
        }
    }

    return result;
}