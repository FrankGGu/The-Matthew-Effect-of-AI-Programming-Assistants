#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LENGTH 100
#define MAX_WORDS 10000

typedef struct {
    char **words;
    int *count;
    int size;
} HashTable;

HashTable* createHashTable(char **words, int size) {
    HashTable *table = (HashTable *)malloc(sizeof(HashTable));
    table->words = (char **)malloc(size * sizeof(char *));
    table->count = (int *)calloc(size, sizeof(int));
    table->size = size;

    for (int i = 0; i < size; i++) {
        table->words[i] = words[i];
    }
    return table;
}

int hash(char *word) {
    int hashValue = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        hashValue = (hashValue * 31 + word[i]) % MAX_WORDS;
    }
    return hashValue;
}

int isEqual(char *a, char *b) {
    return strcmp(a, b) == 0;
}

int checkWords(char *s, int start, HashTable *table, int wordLength, int wordCount) {
    int count = 0;
    int *seen = (int *)calloc(table->size, sizeof(int));

    for (int i = start; i <= strlen(s) - wordLength; i += wordLength) {
        char *word = strndup(s + i, wordLength);
        int index = -1;

        for (int j = 0; j < table->size; j++) {
            if (isEqual(word, table->words[j])) {
                index = j;
                break;
            }
        }

        if (index != -1 && seen[index] < table->count[index]) {
            seen[index]++;
            count++;
        } else {
            free(word);
            free(seen);
            return 0;
        }

        free(word);
        if (count == wordCount) {
            free(seen);
            return 1;
        }
    }

    free(seen);
    return 0;
}

int* findSubstring(char *s, char **words, int wordsSize, int *returnSize) {
    int wordLength = strlen(words[0]);
    int totalLength = wordLength * wordsSize;
    int *result = (int *)malloc(MAX_WORDS * sizeof(int));
    *returnSize = 0;

    if (strlen(s) < totalLength) {
        return result;
    }

    HashTable *table = createHashTable(words, wordsSize);
    for (int i = 0; i < wordsSize; i++) {
        table->count[hash(words[i]) % MAX_WORDS]++;
    }

    for (int i = 0; i <= strlen(s) - totalLength; i++) {
        if (checkWords(s, i, table, wordLength, wordsSize)) {
            result[(*returnSize)++] = i;
        }
    }

    free(table->words);
    free(table->count);
    free(table);
    return result;
}