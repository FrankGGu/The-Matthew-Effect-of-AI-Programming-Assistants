#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int val;
    int freq;
    int next; // index to the next entry in the same bucket chain, -1 if end of chain
} HashEntry;

typedef struct {
    int capacity; // size of the buckets array
    int *buckets; // array of indices into entries, -1 if empty
    HashEntry *entries; // array of all entries
    int entry_count; // current number of entries used in entries array
    int max_entries; // maximum possible entries (e.g., numsSize)
} HashTable;

void initHashTable(HashTable *ht, int max_unique_elements) {
    // Choose a prime number for capacity, usually larger than max_unique_elements
    // For max_unique_elements up to 10^5, a prime like 100003 is good for distribution.
    ht->capacity = 100003; 
    ht->buckets = (int *)malloc(sizeof(int) * ht->capacity);
    for (int i = 0; i < ht->capacity; i++) {
        ht->buckets[i] = -1; // -1 indicates an empty bucket
    }

    ht->max_entries = max_unique_elements;
    ht->entries = (HashEntry *)malloc(sizeof(HashEntry) * ht->max_entries);
    ht->entry_count = 0;
}

void freeHashTable(HashTable *ht) {
    free(ht->buckets);
    free(ht->entries);
}

void addOrUpdate(HashTable *ht, int val) {
    // Hash function: ensures a non-negative index for negative values
    int hash_idx = (val % ht->capacity + ht->capacity) % ht->capacity;

    // Search for the value in the linked list (chain) at this bucket
    int current_entry_idx = ht->buckets[hash_idx];
    while (current_entry_idx != -1) {
        if (ht->entries[current_entry_idx].val == val) {
            ht->entries[current_entry_idx].freq++;
            return; // Value found and frequency updated
        }
        current_entry_idx = ht->entries[current_entry_idx].next;
    }

    // Value not found, add a new entry
    // Check if there's space for a new entry in the entries array
    if (ht->entry_count >= ht->max_entries) {
        // This case should ideally not be reached if max_entries is correctly set
        // (e.g., to numsSize, as there can be at most numsSize unique elements).
        return; 
    }

    int new_entry_idx = ht->entry_count++;
    ht->entries[new_entry_idx].val = val;
    ht->entries[new_entry_idx].freq = 1;
    ht->entries[new_entry_idx].next = ht->buckets[hash_idx]; // Link new entry to the head of the chain
    ht->buckets[hash_idx] = new_entry_idx; // Update bucket to point to the new entry
}

typedef struct {
    int val;
    int freq;
} FreqPair;

int compareFreqPairs(const void *a, const void *b) {
    FreqPair *pairA = (FreqPair *)a;
    FreqPair *pairB = (FreqPair *)b;
    // Sort in descending order of frequency
    return pairB->freq - pairA->freq; 
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    HashTable ht;
    // Initialize hash table. Max unique elements can be numsSize.
    initHashTable(&ht, numsSize); 

    // 1. Count frequencies of all numbers in the input array
    for (int i = 0; i < numsSize; i++) {
        addOrUpdate(&ht, nums[i]);
    }

    // 2. Transfer (value, frequency) pairs from the hash table to a dynamic array
    FreqPair *freq_pairs = (FreqPair *)malloc(sizeof(FreqPair) * ht.entry_count);
    for (int i = 0; i < ht.entry_count; i++) {
        freq_pairs[i].val = ht.entries[i].val;
        freq_pairs[i].freq = ht.entries[i].freq;
    }

    // 3. Sort the array of frequency pairs by frequency in descending order
    qsort(freq_pairs, ht.entry_count, sizeof(FreqPair), compareFreqPairs);

    // 4. Extract the values of the top k frequent elements
    int *result = (int *)malloc(sizeof(int) * k);
    for (int i = 0; i < k; i++) {
        result[i] = freq_pairs[i].val;
    }

    // Set the size of the returned array
    *returnSize = k;

    // Clean up dynamically allocated memory for intermediate structures
    free(freq_pairs);
    freeHashTable(&ht);

    return result; // The caller is responsible for freeing this array
}