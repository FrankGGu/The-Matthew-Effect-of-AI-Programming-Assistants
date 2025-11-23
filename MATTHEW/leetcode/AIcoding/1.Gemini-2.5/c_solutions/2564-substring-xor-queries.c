#include <stdlib.h> // For malloc, free
#include <string.h> // For strlen

#define HASH_TABLE_SIZE 200003 // A prime number for good distribution

typedef struct Entry {
    int key;
    int value_i;
    int value_j;
    struct Entry* next;
} Entry;

Entry* hash_table[HASH_TABLE_SIZE];

void init_hash_table() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        hash_table[i] = NULL;
    }
}

void insert_hash(int key, int i, int j) {
    unsigned int hash_idx = key % HASH_TABLE_SIZE;
    Entry* current = hash_table[hash_idx];
    while (current != NULL) {
        if (current->key == key) {
            return; // Key already present, don't update (first i, then first j)
        }
        current = current->next;
    }
    // Key not found, insert new entry
    Entry* new_entry = (Entry*)malloc(sizeof(Entry));
    new_entry->key = key;
    new_entry->value_i = i;
    new_entry->value_j = j;
    new_entry->next = hash_table[hash_idx]; // Prepend to list
    hash_table[hash_idx] = new_entry;
}

Entry* find_hash(int key) {
    unsigned int hash_idx = key % HASH_TABLE_SIZE;
    Entry* current = hash_table[hash_idx];
    while (current != NULL) {
        if (current->key == key) {
            return current;
        }
        current = current->next;
    }
    return NULL; // Key not found
}

void free_hash_table() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        Entry* current = hash_table[i];
        while (current != NULL) {
            Entry* temp = current;
            current = current->next;
            free(temp);
        }
        hash_table[i] = NULL;
    }
}

int** substringXorQueries(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize, int** returnColumnSizes) {
    init_hash_table();

    int N = strlen(s);
    for (int i = 0; i < N; ++i) {
        long long current_value = 0; // Use long long to prevent overflow before checking max value
        // The maximum value for `first ^ second` is `(1 << 30) - 1`.
        // A substring representing this value will have at most 30 bits.
        // E.g., '1' followed by 29 '0's is `2^29`, length 30.
        // '1' followed by 29 '1's (30 ones) is `2^30 - 1`, length 30.
        // A substring of length 31 starting with '1' would be `2^30` or more, which is too large.
        // So, we only need to consider substrings up to length 30.
        // The loop condition `j < i + 31` allows for a maximum length of 31.
        // The `current_value >= (1LL << 30)` check will correctly stop processing if the value exceeds `2^30 - 1`.
        for (int j = i; j < N && j < i + 31; ++j) {
            current_value = current_value * 2 + (s[j] - '0');
            if (current_value >= (1LL << 30)) { // If value exceeds max possible query result (2^30 - 1), stop extending
                break;
            }
            insert_hash((int)current_value, i, j);
        }
    }

    *returnSize = queriesSize;
    *returnColumnSizes = (int*)malloc(queriesSize * sizeof(int));
    int** result = (int**)malloc(queriesSize * sizeof(int*));

    for (int k = 0; k < queriesSize; ++k) {
        int first = queries[k][0];
        int second = queries[k][1];
        int x = first ^ second;

        result[k] = (int*)malloc(2 * sizeof(int));
        (*returnColumnSizes)[k] = 2; // Each result row has 2 columns [start_idx, end_idx]

        Entry* found = find_hash(x);
        if (found != NULL) {
            result[k][0] = found->value_i;
            result[k][1] = found->value_j;
        } else {
            result[k][0] = -1;
            result[k][1] = -1;
        }
    }

    free_hash_table(); // Free memory allocated for hash table entries

    return result;
}