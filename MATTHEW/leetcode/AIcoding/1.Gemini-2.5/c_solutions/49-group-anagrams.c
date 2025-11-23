#include <stdlib.h> // For malloc, realloc, free, qsort
#include <string.h> // For strlen, strcmp, strdup

#define HASH_TABLE_SIZE 10007 

typedef struct Entry {
    char* key;          // The sorted string (canonical form)
    char** values;      // Array of original strings that are anagrams
    int value_count;    // Number of strings in 'values'
    int value_capacity; // Current allocated capacity for 'values'
    struct Entry* next; // Pointer to the next entry in case of collision (separate chaining)
} Entry;

Entry* hashTable[HASH_TABLE_SIZE];

unsigned int hash(const char* s) {
    unsigned int h = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        h = (h * 31) + s[i]; // Polynomial rolling hash
    }
    return h;
}

int compareChars(const void* a, const void* b) {
    return (*(char*)a - *(char*)b);
}

void sortString(char* s) {
    qsort(s, strlen(s), sizeof(char), compareChars);
}

Entry* findEntry(const char* key, unsigned int h_idx) {
    Entry* current = hashTable[h_idx];
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

void addStringToEntry(Entry* entry, const char* original_str) {
    if (entry->value_count == entry->value_capacity) {
        // Double capacity if needed, start with 1 if capacity is 0
        entry->value_capacity = (entry->value_capacity == 0) ? 1 : entry->value_capacity * 2;
        entry->values = (char**)realloc(entry->values, entry->value_capacity * sizeof(char*));
    }
    entry->values[entry->value_count++] = strdup(original_str);
}

Entry* createAndAddEntry(char* key, const char* original_str, unsigned int h_idx) {
    Entry* newEntry = (Entry*)malloc(sizeof(Entry));
    newEntry->key = key; // Ownership of 'key' transferred to newEntry
    newEntry->values = NULL; // Will be allocated by addStringToEntry
    newEntry->value_count = 0;
    newEntry->value_capacity = 0;
    newEntry->next = hashTable[h_idx]; // Prepend to the list in the bucket
    hashTable[h_idx] = newEntry;

    addStringToEntry(newEntry, original_str);
    return newEntry;
}

char*** groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSizes) {
    // Initialize hash table to NULL
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        hashTable[i] = NULL;
    }

    // Process each string in the input array
    for (int i = 0; i < strsSize; i++) {
        char* s = strs[i];
        char* key = strdup(s); // Duplicate the string to create a sortable key
        sortString(key); // Sort the duplicated string to get its canonical form

        unsigned int h_val = hash(key);
        unsigned int h_idx = h_val % HASH_TABLE_SIZE;

        Entry* entry = findEntry(key, h_idx);
        if (entry != NULL) {
            // An entry for this anagram group already exists, add the current string to it
            addStringToEntry(entry, s);
            free(key); // The temporary key is no longer needed
        } else {
            // No entry found, create a new one
            createAndAddEntry(key, s, h_idx); // 'key' ownership is transferred here
        }
    }

    // Collect results from the hash table
    // Initial capacity for the result arrays. Estimate based on strsSize.
    int current_result_capacity = (strsSize > 0) ? strsSize : 1; 
    char*** result = (char***)malloc(current_result_capacity * sizeof(char**));
    *returnColumnSizes = (int*)malloc(current_result_capacity * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        Entry* current = hashTable[i];
        while (current != NULL) {
            if (*returnSize == current_result_capacity) {
                // Resize result arrays if capacity is exceeded
                current_result_capacity *= 2;
                result = (char***)realloc(result, current_result_capacity * sizeof(char**));
                *returnColumnSizes = (int*)realloc(*returnColumnSizes, current_result_capacity * sizeof(int));
            }
            // Transfer ownership of the 'values' array (and its contents) to the result
            result[*returnSize] = current->values;
            (*returnColumnSizes)[*returnSize] = current->value_count;
            (*returnSize)++;
            current = current->next;
        }
    }

    // Clean up hash table entries (keys and Entry structs)
    // The 'values' arrays and the strings within them are now owned by 'result'
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        Entry* current = hashTable[i];
        while (current != NULL) {
            Entry* temp = current;
            free(temp->key); // Free the sorted key string
            // DO NOT free temp->values or its contents, as they are part of the returned 'result'
            current = current->next;
            free(temp); // Free the Entry struct itself
        }
        hashTable[i] = NULL; // Reset bucket for potential future calls (or good practice)
    }

    return result;
}