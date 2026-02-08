#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **removeAnagrams(char **words, int wordsSize, int *returnSize) {
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        if (i == 0 || strcmp(words[i], words[i - 1]) != 0) {
            result[count++] = words[i];
        }
    }

    *returnSize = count;
    return result;
}