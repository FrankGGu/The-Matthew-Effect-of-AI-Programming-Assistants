#include <stdlib.h> // For malloc, free, abs

#define HASH_TABLE_SIZE 200003 // A prime number

typedef struct Entry {
    int key;
    int value; // Stores the index of the number in the original array
    struct Entry* next;
} Entry;

Entry* hashTable[HASH_TABLE_SIZE];

int getHash(int key) {
    // Use absolute value to handle potential negative numbers (though prices are usually positive)
    // and ensure the hash index is non-negative.
    return abs(key % HASH_TABLE_SIZE);
}

void insert(int key, int value) {
    int index = getHash(key);
    Entry* newEntry = (Entry*)malloc(sizeof(Entry));
    newEntry->key = key;
    newEntry->value = value;
    newEntry->next = hashTable[index]; // Add to the beginning of the list
    hashTable[index] = newEntry;
}

int search(int key) {
    int index = getHash(key);
    Entry* current = hashTable[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value; // Key found, return its associated value (index)
        }
        current = current->next;
    }
    return -1; // Key not found
}

void initHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        hashTable[i] = NULL;
    }
}

void freeHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        Entry* current = hashTable[i];
        while (current != NULL) {
            Entry* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL; // Reset the bucket pointer
    }
}

int* twoSum(int* prices, int pricesSize, int target, int* returnSize) {
    // Initialize the hash table before use
    initHashTable();

    int* result = (int*)malloc(2 * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL; // Handle malloc failure
    }

    for (int i = 0; i < pricesSize; i++) {
        int complement = target - prices[i];
        int complementIndex = search(complement);

        if (complementIndex != -1) {
            // Found the complement, store the indices and return
            result[0] = complementIndex;
            result[1] = i;
            *returnSize = 2;
            freeHashTable(); // Free hash table memory before returning
            return result;
        }

        // Complement not found, add the current number and its index to the hash table
        insert(prices[i], i);
    }

    // According to typical LeetCode problem statements for Two Sum,
    // there is exactly one solution, so this part should not be reached.
    // However, for robustness, if no solution were found, we would clean up.
    free(result);
    *returnSize = 0;
    freeHashTable(); // Free hash table memory
    return NULL;
}