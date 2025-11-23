#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * mostCommonWord(char * paragraph, char ** banned, int bannedSize) {
    int len = strlen(paragraph);
    char *word = (char *)malloc(len + 1);
    int wordIndex = 0;
    int maxFreq = 0;
    char *result = (char *)malloc(len + 1);
    result[0] = '\0';

    int *freq = (int *)malloc(sizeof(int) * 10000);
    char **words = (char **)malloc(sizeof(char *) * 10000);
    int wordCount = 0;

    for (int i = 0; i < 10000; i++) {
        freq[i] = 0;
        words[i] = (char *)malloc(len + 1);
        words[i][0] = '\0';
    }

    for (int i = 0; i <= len; i++) {
        if (isalpha(paragraph[i])) {
            word[wordIndex++] = tolower(paragraph[i]);
        } else if (wordIndex > 0) {
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
                for (int j = 0; j < wordCount; j++) {
                    if (strcmp(word, words[j]) == 0) {
                        freq[j]++;
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    strcpy(words[wordCount], word);
                    freq[wordCount] = 1;
                    wordCount++;
                }

            }
            wordIndex = 0;
        }
    }

    for (int i = 0; i < wordCount; i++) {
        if (freq[i] > maxFreq) {
            maxFreq = freq[i];
            strcpy(result, words[i]);
        }
    }

    free(word);
    for(int i=0; i<10000; i++){
        free(words[i]);
    }
    free(words);
    free(freq);

    return result;
}