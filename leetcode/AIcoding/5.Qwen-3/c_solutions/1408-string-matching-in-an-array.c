#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **stringMatching(char **words, int wordsSize, int *returnSize) {
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordsSize; j++) {
            if (i != j && strstr(words[j], words[i])) {
                result[count++] = words[i];
                break;
            }
        }
    }

    *returnSize = count;
    return result;
}