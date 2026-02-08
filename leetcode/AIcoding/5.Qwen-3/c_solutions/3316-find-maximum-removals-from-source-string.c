#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int value;
} Pair;

int compare(const void *a, const void *b) {
    return strcmp(((Pair *)a)->key, ((Pair *)b)->key);
}

int findMaximumRemovalsFromSourceString(char *source, char *target, char **dictionary) {
    int dictSize = 0;
    while (dictionary[dictSize] != NULL) {
        dictSize++;
    }

    Pair *dictPairs = (Pair *)malloc(dictSize * sizeof(Pair));
    for (int i = 0; i < dictSize; i++) {
        dictPairs[i].key = dictionary[i];
        dictPairs[i].value = 0;
    }

    qsort(dictPairs, dictSize, sizeof(Pair), compare);

    int *count = (int *)calloc(dictSize, sizeof(int));
    int maxRemovals = 0;

    for (int i = 0; i < dictSize; i++) {
        char *word = dictPairs[i].key;
        int len = strlen(word);
        int j = 0;
        int k = 0;
        while (j < strlen(source) && k < len) {
            if (source[j] == word[k]) {
                k++;
            }
            j++;
        }
        if (k == len) {
            count[i] = 1;
        } else {
            count[i] = 0;
        }
    }

    for (int i = 0; i < dictSize; i++) {
        if (count[i] == 1) {
            int temp = 0;
            char *word = dictPairs[i].key;
            int len = strlen(word);
            int j = 0;
            int k = 0;
            while (j < strlen(source) && k < len) {
                if (source[j] == word[k]) {
                    temp++;
                    k++;
                }
                j++;
            }
            if (temp == len) {
                maxRemovals++;
            }
        }
    }

    free(count);
    free(dictPairs);
    return maxRemovals;
}