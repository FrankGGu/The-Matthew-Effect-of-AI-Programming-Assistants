#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int score;
} WordScore;

int compare(const void *a, const void *b) {
    return strcmp(((WordScore *)a)->word, ((WordScore *)b)->word);
}

int* prefixScores(char** words, int wordsSize, int* returnSize) {
    int* scores = (int*)malloc(wordsSize * sizeof(int));
    int* prefixCount = (int*)calloc(100000, sizeof(int)); // Sufficient size for all possible prefixes
    int maxLen = 0;

    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        maxLen = (len > maxLen) ? len : maxLen;
    }

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        for (int j = 1; j <= strlen(word); j++) {
            char prefix[100] = {0};
            strncpy(prefix, word, j);
            int hash = 0;
            for (int k = 0; k < j; k++) {
                hash = hash * 257 + (unsigned char)prefix[k];
            }
            prefixCount[hash]++;
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int score = 0;
        for (int j = 1; j <= strlen(word); j++) {
            char prefix[100] = {0};
            strncpy(prefix, word, j);
            int hash = 0;
            for (int k = 0; k < j; k++) {
                hash = hash * 257 + (unsigned char)prefix[k];
            }
            score += prefixCount[hash];
        }
        scores[i] = score;
    }

    *returnSize = wordsSize;
    return scores;
}