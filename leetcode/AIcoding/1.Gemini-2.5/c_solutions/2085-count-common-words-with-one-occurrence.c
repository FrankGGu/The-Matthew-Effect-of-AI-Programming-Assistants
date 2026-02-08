#include <stdlib.h> // For malloc, free
#include <string.h> // For strcmp, strcpy

#define MAX_WORD_LEN 31      // Maximum word length (30) + null terminator
#define HASH_TABLE_SIZE 4001 // A prime number for the hash table size

typedef struct HashEntry {
    char word[MAX_WORD_LEN];
    int count;
    struct HashEntry *next; // Pointer for separate chaining
} HashEntry;

static unsigned int hash(const char *str) {
    unsigned int h = 5381; // Initial seed
    int c;
    while ((c = *str++)) {
        h = ((h << 5) + h) + c; // h * 33 + c
    }
    return h % HASH_TABLE_SIZE;
}

static void insertWord(HashEntry **table, const char *word) {
    unsigned int index = hash(word);
    HashEntry *current = table[index];

    // Check if word already exists in the chain
    while (current != NULL) {
        if (strcmp(current->word, word) == 0) {
            current->count++;
            return;
        }
        current = current->next;
    }

    // Word not found, create a new entry
    HashEntry *newEntry = (HashEntry *)malloc(sizeof(HashEntry));
    strcpy(newEntry->word, word);
    newEntry->count = 1;
    newEntry->next = table[index]; // Add new entry to the head of the list
    table[index] = newEntry;
}

static int getWordCount(HashEntry **table, const char *word) {
    unsigned int index = hash(word);
    HashEntry *current = table[index];

    while (current != NULL) {
        if (strcmp(current->word, word) == 0) {
            return current->count;
        }
        current = current->next;
    }
    return 0; // Word not found
}

static void freeHashTable(HashEntry **table) {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        HashEntry *current = table[i];
        while (current != NULL) {
            HashEntry *temp = current;
            current = current->next;
            free(temp);
        }
        table[i] = NULL; // Clear pointer after freeing chain
    }
}

int countCommonWords(char **words1, int words1Size, char **words2, int words2Size) {
    // Declare and initialize hash tables (pointers to HashEntry structs)
    HashEntry *hashTable1[HASH_TABLE_SIZE] = {NULL}; // Initialize all pointers to NULL
    HashEntry *hashTable2[HASH_TABLE_SIZE] = {NULL}; // Initialize all pointers to NULL

    // Populate hashTable1 with word counts from words1
    for (int i = 0; i < words1Size; i++) {
        insertWord(hashTable1, words1[i]);
    }

    // Populate hashTable2 with word counts from words2
    for (int i = 0; i < words2Size; i++) {
        insertWord(hashTable2, words2[i]);
    }

    int commonCount = 0;

    // Iterate through words1 to find words that appear exactly once in both lists
    for (int i = 0; i < words1Size; i++) {
        const char *word = words1[i];
        if (getWordCount(hashTable1, word) == 1 && getWordCount(hashTable2, word) == 1) {
            commonCount++;
        }
    }

    // Clean up allocated memory for hash tables
    freeHashTable(hashTable1);
    freeHashTable(hashTable2);

    return commonCount;
}