#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char* word;
    int count;
} WordCount;

char* mostCommonWord(char* paragraph, char** banned, int bannedSize) {
    char* tokens[1000];
    int tokenCount = 0;
    char* copy = strdup(paragraph);
    char* token = strtok(copy, " !?',;.");

    while (token != NULL) {
        tokens[tokenCount++] = token;
        token = strtok(NULL, " !?',;.");
    }

    WordCount wordCounts[1000];
    int wordCountSize = 0;

    for (int i = 0; i < tokenCount; i++) {
        char* word = tokens[i];
        for (int j = 0; word[j]; j++) {
            word[j] = tolower(word[j]);
        }

        int isBanned = 0;
        for (int k = 0; k < bannedSize; k++) {
            if (strcmp(word, banned[k]) == 0) {
                isBanned = 1;
                break;
            }
        }

        if (isBanned || strlen(word) == 0) {
            continue;
        }

        int found = -1;
        for (int k = 0; k < wordCountSize; k++) {
            if (strcmp(wordCounts[k].word, word) == 0) {
                found = k;
                break;
            }
        }

        if (found != -1) {
            wordCounts[found].count++;
        } else {
            wordCounts[wordCountSize].word = strdup(word);
            wordCounts[wordCountSize].count = 1;
            wordCountSize++;
        }
    }

    int maxCount = 0;
    char* result = NULL;

    for (int i = 0; i < wordCountSize; i++) {
        if (wordCounts[i].count > maxCount) {
            maxCount = wordCounts[i].count;
            result = wordCounts[i].word;
        }
    }

    free(copy);
    for (int i = 0; i < wordCountSize; i++) {
        if (wordCounts[i].word != result) {
            free(wordCounts[i].word);
        }
    }

    return result;
}