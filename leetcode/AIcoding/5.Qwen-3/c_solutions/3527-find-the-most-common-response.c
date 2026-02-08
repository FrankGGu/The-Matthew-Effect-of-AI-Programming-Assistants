#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *response;
    int count;
} ResponseCount;

int compare(const void *a, const void *b) {
    ResponseCount *x = (ResponseCount *)a;
    ResponseCount *y = (ResponseCount *)b;
    return y->count - x->count;
}

char* mostCommonWord(char* paragraph, char** banned, int bannedSize) {
    int len = strlen(paragraph);
    char *word = (char *)malloc(100 * sizeof(char));
    int wordIndex = 0;
    int maxCount = 0;
    char *result = NULL;

    ResponseCount *counts = (ResponseCount *)calloc(1000, sizeof(ResponseCount));
    int countIndex = 0;

    for (int i = 0; i <= len; i++) {
        if (paragraph[i] == ' ' || paragraph[i] == '\0') {
            if (wordIndex > 0) {
                word[wordIndex] = '\0';
                int isBanned = 0;
                for (int j = 0; j < bannedSize; j++) {
                    if (strcmp(word, banned[j]) == 0) {
                        isBanned = 1;
                        break;
                    }
                }
                if (!isBanned) {
                    int found = 0;
                    for (int k = 0; k < countIndex; k++) {
                        if (strcmp(counts[k].response, word) == 0) {
                            counts[k].count++;
                            found = 1;
                            break;
                        }
                    }
                    if (!found) {
                        counts[countIndex].response = strdup(word);
                        counts[countIndex].count = 1;
                        countIndex++;
                    }
                }
                wordIndex = 0;
            }
        } else {
            char c = tolower(paragraph[i]);
            if (c >= 'a' && c <= 'z') {
                word[wordIndex++] = c;
            }
        }
    }

    qsort(counts, countIndex, sizeof(ResponseCount), compare);

    for (int i = 0; i < countIndex; i++) {
        if (counts[i].count > maxCount) {
            maxCount = counts[i].count;
            result = counts[i].response;
        }
    }

    free(word);
    for (int i = 0; i < countIndex; i++) {
        free(counts[i].response);
    }
    free(counts);

    return result;
}