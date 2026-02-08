#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LENGTH 100
#define MAX_BANNED_WORDS 100
#define MAX_WORD_COUNT 200

typedef struct {
    char word[MAX_WORD_LENGTH];
    int count;
} WordCount;

char *mostCommonWord(char *paragraph, char **banned, int bannedSize) {
    WordCount wordCounts[MAX_WORD_COUNT];
    int wordCount = 0;
    char *result = NULL;
    int maxCount = 0;

    for (int i = 0; i < MAX_WORD_COUNT; i++) {
        wordCounts[i].word[0] = '\0';
        wordCounts[i].count = 0;
    }

    char *token = strtok(paragraph, " !?',;.");
    while (token != NULL) {
        for (int i = 0; token[i]; i++) {
            token[i] = tolower(token[i]);
        }

        int isBanned = 0;
        for (int i = 0; i < bannedSize; i++) {
            if (strcmp(token, banned[i]) == 0) {
                isBanned = 1;
                break;
            }
        }

        if (!isBanned) {
            int found = 0;
            for (int i = 0; i < wordCount; i++) {
                if (strcmp(token, wordCounts[i].word) == 0) {
                    wordCounts[i].count++;
                    found = 1;
                    break;
                }
            }

            if (!found) {
                strcpy(wordCounts[wordCount].word, token);
                wordCounts[wordCount].count = 1;
                wordCount++;
            }
        }
        token = strtok(NULL, " !?',;.");
    }

    for (int i = 0; i < wordCount; i++) {
        if (wordCounts[i].count > maxCount) {
            maxCount = wordCounts[i].count;
            result = wordCounts[i].word;
        }
    }

    return result;
}