/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

#define MAX_WORDS 3000
#define MAX_LENGTH 100

typedef struct {
    char* original;
    char* lower;
    char* devowel;
} WordPattern;

int isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
           c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
}

char* toLowerCase(char* s) {
    char* result = strdup(s);
    for (int i = 0; result[i]; i++) {
        if (result[i] >= 'A' && result[i] <= 'Z') {
            result[i] = result[i] - 'A' + 'a';
        }
    }
    return result;
}

char* devowel(char* s) {
    char* result = strdup(s);
    for (int i = 0; result[i]; i++) {
        if (isVowel(result[i])) {
            result[i] = '*';
        }
    }
    return result;
}

char** spellchecker(char** wordlist, int wordlistSize, char** queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    char** result = (char**)malloc(queriesSize * sizeof(char*));

    WordPattern* patterns = (WordPattern*)malloc(wordlistSize * sizeof(WordPattern));

    for (int i = 0; i < wordlistSize; i++) {
        patterns[i].original = wordlist[i];
        patterns[i].lower = toLowerCase(wordlist[i]);
        patterns[i].devowel = devowel(patterns[i].lower);
    }

    for (int i = 0; i < queriesSize; i++) {
        char* query = queries[i];
        char* queryLower = toLowerCase(query);
        char* queryDevowel = devowel(queryLower);

        char* exactMatch = NULL;
        char* caseMatch = NULL;
        char* vowelMatch = NULL;

        for (int j = 0; j < wordlistSize; j++) {
            if (exactMatch == NULL && strcmp(query, patterns[j].original) == 0) {
                exactMatch = patterns[j].original;
            }
            if (caseMatch == NULL && strcmp(queryLower, patterns[j].lower) == 0) {
                caseMatch = patterns[j].original;
            }
            if (vowelMatch == NULL && strcmp(queryDevowel, patterns[j].devowel) == 0) {
                vowelMatch = patterns[j].original;
            }
        }

        if (exactMatch != NULL) {
            result[i] = strdup(exactMatch);
        } else if (caseMatch != NULL) {
            result[i] = strdup(caseMatch);
        } else if (vowelMatch != NULL) {
            result[i] = strdup(vowelMatch);
        } else {
            result[i] = strdup("");
        }

        free(queryLower);
        free(queryDevowel);
    }

    for (int i = 0; i < wordlistSize; i++) {
        free(patterns[i].lower);
        free(patterns[i].devowel);
    }
    free(patterns);

    return result;
}