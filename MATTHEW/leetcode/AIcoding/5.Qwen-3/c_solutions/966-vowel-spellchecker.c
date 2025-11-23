#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** spellchecker(char** wordlist, int wordlistSize, char** queries, int queriesSize, int* returnSize) {
    char** result = (char**)malloc(queriesSize * sizeof(char*));
    *returnSize = 0;

    char** lowerMap = (char**)malloc(wordlistSize * sizeof(char*));
    char** vowelMap = (char**)malloc(wordlistSize * sizeof(char*));

    for (int i = 0; i < wordlistSize; ++i) {
        lowerMap[i] = (char*)malloc((strlen(wordlist[i]) + 1) * sizeof(char));
        strcpy(lowerMap[i], wordlist[i]);
        for (int j = 0; lowerMap[i][j]; ++j)
            lowerMap[i][j] = tolower(lowerMap[i][j]);

        vowelMap[i] = (char*)malloc((strlen(wordlist[i]) + 1) * sizeof(char));
        strcpy(vowelMap[i], lowerMap[i]);
        for (int j = 0; vowelMap[i][j]; ++j)
            if (vowelMap[i][j] == 'a' || vowelMap[i][j] == 'e' || vowelMap[i][j] == 'i' || vowelMap[i][j] == 'o' || vowelMap[i][j] == 'u')
                vowelMap[i][j] = '*';
    }

    for (int q = 0; q < queriesSize; ++q) {
        char* query = queries[q];
        char* lowerQuery = (char*)malloc((strlen(query) + 1) * sizeof(char));
        strcpy(lowerQuery, query);
        for (int j = 0; lowerQuery[j]; ++j)
            lowerQuery[j] = tolower(lowerQuery[j]);

        char* vowelQuery = (char*)malloc((strlen(query) + 1) * sizeof(char));
        strcpy(vowelQuery, lowerQuery);
        for (int j = 0; vowelQuery[j]; ++j)
            if (vowelQuery[j] == 'a' || vowelQuery[j] == 'e' || vowelQuery[j] == 'i' || vowelQuery[j] == 'o' || vowelQuery[j] == 'u')
                vowelQuery[j] = '*';

        char* found = NULL;
        for (int i = 0; i < wordlistSize; ++i) {
            if (strcmp(wordlist[i], query) == 0) {
                found = wordlist[i];
                break;
            }
            if (strcmp(lowerMap[i], lowerQuery) == 0) {
                found = wordlist[i];
                break;
            }
            if (strcmp(vowelMap[i], vowelQuery) == 0) {
                found = wordlist[i];
                break;
            }
        }

        result[*returnSize] = found ? strdup(found) : NULL;
        (*returnSize)++;
        free(lowerQuery);
        free(vowelQuery);
    }

    for (int i = 0; i < wordlistSize; ++i) {
        free(lowerMap[i]);
        free(vowelMap[i]);
    }
    free(lowerMap);
    free(vowelMap);

    return result;
}