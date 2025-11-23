#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* mostCommonWord(char* paragraph, char** banned, int bannedSize) {
    int len = strlen(paragraph);
    char* word = (char*)malloc(100 * sizeof(char));
    int wordIndex = 0;
    int maxCount = 0;
    char* result = NULL;
    int* count = (int*)calloc(1000, sizeof(int));
    char** words = (char**)malloc(1000 * sizeof(char*));

    for (int i = 0; i < 1000; i++) {
        words[i] = (char*)malloc(100 * sizeof(char));
    }

    int wordCount = 0;

    for (int i = 0; i <= len; i++) {
        if (isalpha(paragraph[i])) {
            word[wordIndex++] = tolower(paragraph[i]);
        } else if (wordIndex > 0) {
            word[wordIndex] = '\0';
            strcpy(words[wordCount], word);
            wordCount++;
            wordIndex = 0;
            memset(word, 0, 100 * sizeof(char));
        }
    }

    for (int i = 0; i < wordCount; i++) {
        int found = 0;
        for (int j = 0; j < bannedSize; j++) {
            if (strcmp(words[i], banned[j]) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            count[i] = 1;
            for (int j = 0; j < wordCount; j++) {
                if (i != j && strcmp(words[i], words[j]) == 0) {
                    count[i]++;
                }
            }
            if (count[i] > maxCount) {
                maxCount = count[i];
                result = words[i];
            }
        }
    }

    for (int i = 0; i < 1000; i++) {
        free(words[i]);
    }
    free(words);
    free(word);
    free(count);

    return result;
}