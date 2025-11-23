#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 11
#define MAX_WORDS 101

bool isWithinTwoEdits(const char *query, const char *word) {
    int diff = 0;
    for (int i = 0; query[i] != '\0' && word[i] != '\0'; ++i) {
        if (query[i] != word[i]) {
            diff++;
        }
        if (diff > 2) {
            return false;
        }
    }
    return true;
}

char **stringMatching(char **queries, int queriesSize, char **dictionary, int dictionarySize, int *returnSize) {
    char **result = (char **)malloc(queriesSize * sizeof(char *));
    *returnSize = 0;

    for (int i = 0; i < queriesSize; ++i) {
        for (int j = 0; j < dictionarySize; ++j) {
            if (strlen(queries[i]) == strlen(dictionary[j]) && isWithinTwoEdits(queries[i], dictionary[j])) {
                result[*returnSize] = (char *)malloc((strlen(queries[i]) + 1) * sizeof(char));
                strcpy(result[*returnSize], queries[i]);
                (*returnSize)++;
                break;
            }
        }
    }

    return result;
}

char **wordsWithinTwoEdits(char **queries, int queriesSize, char **dictionary, int dictionarySize, int *returnSize){
    return stringMatching(queries, queriesSize, dictionary, dictionarySize, returnSize);
}