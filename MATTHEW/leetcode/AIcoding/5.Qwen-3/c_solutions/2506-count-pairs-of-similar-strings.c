#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strcmp(*(char **)a, *(char **)b);
}

char* getUniqueString(char* s) {
    int len = strlen(s);
    char* unique = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;
    for (int i = 0; i < len; i++) {
        if (i == 0 || s[i] != s[i - 1]) {
            unique[index++] = s[i];
        }
    }
    unique[index] = '\0';
    return unique;
}

int similarPairs(char** words, int wordsSize) {
    char** uniqueWords = (char**)malloc(wordsSize * sizeof(char*));
    for (int i = 0; i < wordsSize; i++) {
        uniqueWords[i] = getUniqueString(words[i]);
    }

    qsort(uniqueWords, wordsSize, sizeof(char*), compare);

    int count = 0;
    for (int i = 0; i < wordsSize - 1; i++) {
        if (strcmp(uniqueWords[i], uniqueWords[i + 1]) == 0) {
            count++;
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        free(uniqueWords[i]);
    }
    free(uniqueWords);

    return count;
}