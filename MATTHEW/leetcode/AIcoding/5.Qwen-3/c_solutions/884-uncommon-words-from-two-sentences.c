#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **uncommonFromSentences(char *s1, char *s2, int *returnSize) {
    char **result = NULL;
    int resultSize = 0;
    int capacity = 0;

    // Count word frequencies
    int wordCount = 0;
    char **words = NULL;
    char *temp = malloc(strlen(s1) + strlen(s2) + 1);
    strcpy(temp, s1);
    strcat(temp, " ");
    strcat(temp, s2);

    char *token = strtok(temp, " ");
    while (token != NULL) {
        wordCount++;
        words = realloc(words, wordCount * sizeof(char *));
        words[wordCount - 1] = malloc(strlen(token) + 1);
        strcpy(words[wordCount - 1], token);
        token = strtok(NULL, " ");
    }
    free(temp);

    // Count frequency of each word
    int freqSize = 0;
    char **freqWords = NULL;
    int *freq = NULL;
    for (int i = 0; i < wordCount; i++) {
        int found = 0;
        for (int j = 0; j < freqSize; j++) {
            if (strcmp(words[i], freqWords[j]) == 0) {
                freq[j]++;
                found = 1;
                break;
            }
        }
        if (!found) {
            freqSize++;
            freqWords = realloc(freqWords, freqSize * sizeof(char *));
            freqWords[freqSize - 1] = malloc(strlen(words[i]) + 1);
            strcpy(freqWords[freqSize - 1], words[i]);
            freq = realloc(freq, freqSize * sizeof(int));
            freq[freqSize - 1] = 1;
        }
    }

    // Collect uncommon words
    for (int i = 0; i < freqSize; i++) {
        if (freq[i] == 1) {
            resultSize++;
            if (resultSize > capacity) {
                capacity = (capacity == 0) ? 1 : capacity * 2;
                result = realloc(result, capacity * sizeof(char *));
            }
            result[resultSize - 1] = malloc(strlen(freqWords[i]) + 1);
            strcpy(result[resultSize - 1], freqWords[i]);
        }
    }

    *returnSize = resultSize;
    return result;
}