#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **commonChars(char **words, int wordsSize, int *returnSize) {
    int common[26] = {0};
    int i, j;

    for (i = 0; words[0][i]; i++) {
        common[words[0][i] - 'a']++;
    }

    for (i = 1; i < wordsSize; i++) {
        int count[26] = {0};
        for (j = 0; words[i][j]; j++) {
            count[words[i][j] - 'a']++;
        }

        for (j = 0; j < 26; j++) {
            common[j] = (common[j] < count[j]) ? common[j] : count[j];
        }
    }

    int size = 0;
    for (i = 0; i < 26; i++) {
        size += common[i];
    }

    char **result = (char **)malloc(size * sizeof(char *));
    int index = 0;

    for (i = 0; i < 26; i++) {
        for (int j = 0; j < common[i]; j++) {
            result[index] = (char *)malloc(2 * sizeof(char));
            result[index++][0] = i + 'a';
            result[index - 1][1] = '\0';
        }
    }

    *returnSize = size;
    return result;
}