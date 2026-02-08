#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct Entry {
    char *key;
    int count;
    struct Entry *next;
} Entry;

#define HASH_TABLE_SIZE 1000
Entry *hashTable[HASH_TABLE_SIZE];

unsigned int hash(const char *str) {
    unsigned int hash_val = 5381; // djb2 hash algorithm
    int c;
    while ((c = *str++)) {
        hash_val = ((hash_val << 5) + hash_val) + c; // hash * 33 + c
    }
    return hash_val % HASH_TABLE_SIZE;
}

void insert(const char *key) {
    unsigned int index = hash(key);
    Entry *current = hashTable[index];

    // Traverse the linked list at this bucket to find if the key already exists
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            current->count++;
            return;
        }
        current = current->next;
    }

    // Key not found, create a new entry
    Entry *newEntry = (Entry *)malloc(sizeof(Entry));
    if (!newEntry) {
        // Handle allocation failure, though LeetCode usually assumes success
        return;
    }
    newEntry->key = strdup(key); // Duplicate the key string to own its memory
    if (!newEntry->key) {
        free(newEntry);
        return;
    }
    newEntry->count = 1;
    newEntry->next = hashTable[index]; // Prepend to the list
    hashTable[index] = newEntry;
}

int isBanned(const char *word, char **banned, int bannedSize) {
    for (int i = 0; i < bannedSize; i++) {
        if (strcmp(word, banned[i]) == 0) {
            return 1; // Word is banned
        }
    }
    return 0; // Word is not banned
}

void freeHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        Entry *current = hashTable[i];
        while (current != NULL) {
            Entry *temp = current;
            current = current->next;
            free(temp->key); // Free the duplicated key string
            free(temp);      // Free the Entry struct
        }
        hashTable[i] = NULL; // Reset the bucket pointer
    }
}

char *mostCommonWord(char *paragraph, char **banned, int bannedSize) {
    // Clear the hash table from any previous calls to ensure a clean state.
    freeHashTable();

    // Preprocess the paragraph: convert to lowercase and replace punctuation with spaces.
    int len = strlen(paragraph);
    for (int i = 0; i < len; i++) {
        if (!isalpha(paragraph[i])) { // If it's not an alphabet character
            paragraph[i] = ' ';       // Replace with space
        } else {
            paragraph[i] = tolower(paragraph[i]); // Convert to lowercase
        }
    }

    // Tokenize the paragraph using space as a delimiter and process each word.
    char *token = strtok(paragraph, " ");
    while (token != NULL) {
        // Only process non-empty tokens that are not banned.
        if (strlen(token) > 0 && !isBanned(token, banned, bannedSize)) {
            insert(token);
        }
        token = strtok(NULL, " "); // Get the next token
    }

    char *mostFrequentWord = NULL;
    int maxCount = 0;

    // Iterate through the hash table to find the word with the maximum count.
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        Entry *current = hashTable[i];
        while (current != NULL) {
            if (current->count > maxCount) {
                maxCount = current->count;
                mostFrequentWord = current->key;
            }
            current = current->next;
        }
    }

    // According to problem constraints, a unique answer is guaranteed,
    // so `mostFrequentWord` will not be NULL.
    // Duplicate the result string, as the original points to memory within the hash table
    // which will be freed by `freeHashTable()`.
    char *result = strdup(mostFrequentWord);

    // Clean up all memory allocated for the hash table.
    freeHashTable();

    return result;
}