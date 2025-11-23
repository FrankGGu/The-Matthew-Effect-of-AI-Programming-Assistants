#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

char* toLowerCase(char* word) {
    for (int i = 0; word[i]; i++) {
        if (word[i] >= 'A' && word[i] <= 'Z') {
            word[i] += 'a' - 'A';
        }
    }
    return word;
}

char* replaceVowels(char* word, char replacement) {
    for (int i = 0; word[i]; i++) {
        if (isVowel(word[i])) {
            word[i] = replacement;
        }
    }
    return word;
}

char* getKey(char* word) {
    char* key = strdup(word);
    for (int i = 0; key[i]; i++) {
        if (isVowel(key[i])) {
            key[i] = '*';
        }
    }
    return key;
}

char** spellchecker(char** wordlist, int wordlistSize, char** queries, int queriesSize, int* returnSize) {
    char** result = (char**)malloc(sizeof(char*) * queriesSize);
    *returnSize = queriesSize;
    bool* found = (bool*)calloc(wordlistSize, sizeof(bool));

    for (int i = 0; i < wordlistSize; i++) {
        char* lowerWord = toLowerCase(strdup(wordlist[i]));
        found[i] = false;
        for (int j = 0; j < wordlistSize; j++) {
            if (strcmp(lowerWord, toLowerCase(strdup(wordlist[j]))) == 0) {
                found[i] = true;
                break;
            }
        }
        free(lowerWord);
    }

    for (int i = 0; i < queriesSize; i++) {
        if (found[i]) {
            result[i] = strdup(queries[i]);
            continue;
        }

        char* key = getKey(queries[i]);
        for (int j = 0; j < wordlistSize; j++) {
            if (strcmp(key, getKey(wordlist[j])) == 0) {
                result[i] = strdup(wordlist[j]);
                break;
            }
        }
        free(key);

        if (!result[i]) {
            result[i] = strdup("");
        }
    }

    for (int i = 0; i < wordlistSize; i++) {
        if (found[i]) {
            free(wordlist[i]);
        }
    }
    free(found);

    return result;
}