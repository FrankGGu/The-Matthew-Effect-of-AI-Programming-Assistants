#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 100

int isVowel(char c) {
    c = tolower(c);
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

char* devowel(char* word) {
    int len = strlen(word);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int j = 0;
    for (int i = 0; i < len; i++) {
        if (isVowel(word[i])) {
            result[j++] = '*';
        } else {
            result[j++] = tolower(word[i]);
        }
    }
    result[j] = '\0';
    return result;
}

char* toLower(char* word) {
    int len = strlen(word);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    for (int i = 0; i < len; i++) {
        result[i] = tolower(word[i]);
    }
    result[len] = '\0';
    return result;
}

char** spellchecker(char** wordlist, int wordlistSize, char** queries, int queriesSize, int* returnSize) {
    char** result = (char**)malloc(queriesSize * sizeof(char*));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        result[i] = NULL;
    }

    for (int i = 0; i < queriesSize; i++) {
        char* query = queries[i];
        for (int j = 0; j < wordlistSize; j++) {
            if (strcmp(query, wordlist[j]) == 0) {
                result[i] = strdup(wordlist[j]);
                break;
            }
        }
        if (result[i] != NULL) continue;

        char* lowerQuery = toLower(query);
        for (int j = 0; j < wordlistSize; j++) {
            char* lowerWord = toLower(wordlist[j]);
            if (strcmp(lowerQuery, lowerWord) == 0) {
                result[i] = strdup(wordlist[j]);
                free(lowerWord);
                break;
            }
            free(lowerWord);
        }
        free(lowerQuery);
        if (result[i] != NULL) continue;

        char* devowelQuery = devowel(query);
        for (int j = 0; j < wordlistSize; j++) {
            char* devowelWord = devowel(wordlist[j]);
            if (strcmp(devowelQuery, devowelWord) == 0) {
                result[i] = strdup(wordlist[j]);
                free(devowelWord);
                break;
            }
            free(devowelWord);
        }
        free(devowelQuery);
        if (result[i] != NULL) continue;

        result[i] = strdup("");
    }

    return result;
}