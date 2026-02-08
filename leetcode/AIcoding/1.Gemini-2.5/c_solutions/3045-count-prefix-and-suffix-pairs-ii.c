#include <stdlib.h>
#include <string.h>

const long long P1 = 31;
const long long M1 = 1e9 + 7;
const long long P2 = 37;
const long long M2 = 1e9 + 9;

long long powP1[101]; // Max word length is 100
long long powP2[101];

int powers_calculated = 0;

void calculate_powers() {
    if (powers_calculated) return;
    powP1[0] = 1;
    powP2[0] = 1;
    for (int i = 1; i <= 100; ++i) {
        powP1[i] = (powP1[i-1] * P1) % M1;
        powP2[i] = (powP2[i-1] * P2) % M2;
    }
    powers_calculated = 1;
}

typedef struct HashNode {
    long long key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** buckets;
    int capacity;
    int size;
} HashMap;

unsigned int hash_func(long long key, int capacity) {
    // A common way to mix bits for better distribution
    key = (key ^ (key >> 32)) * 0x45d9f3b; // Fibonacci hashing constant
    return (unsigned int)(key % capacity);
}

HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->size = 0;
    map->buckets = (HashNode**)calloc(capacity, sizeof(HashNode*));
    return map;
}

void insertHashMap(HashMap* map, long long key, int value) {
    unsigned int index = hash_func(key, map->capacity);
    HashNode* current = map->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            current->value = value; // Update existing value
            return;
        }
        current = current->next;
    }
    // Key not found, insert new node
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[index];
    map->buckets[index] = newNode;
    map->size++;
}

int getHashMap(HashMap* map, long long key) {
    unsigned int index = hash_func(key, map->capacity);
    HashNode* current = map->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return 0; // Key not found, return 0 (default frequency)
}

void freeHashMap(HashMap* map) {
    if (!map) return;
    for (int i = 0; i < map->capacity; ++i) {
        HashNode* current = map->buckets[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

long long countPrefixSuffixPairs(char** words, int wordsSize) {
    calculate_powers(); // Ensure powers are initialized

    long long total_pairs = 0;
    // Capacity for hash map should be chosen to minimize collisions.
    // A load factor of 0.5 to 0.75 is typical. wordsSize * 2 is a good heuristic.
    HashMap* freq_map = createHashMap(wordsSize * 2 + 1); 

    // Temporary arrays for prefix hashes of the current word
    // current_pref_h1[k] stores hash of words[j][0...k-1]
    long long current_pref_h1[101]; 
    long long current_pref_h2[101];

    for (int j = 0; j < wordsSize; ++j) {
        const char* current_word = words[j];
        int len = strlen(current_word);

        // 1. Compute prefix hashes for current_word
        // current_pref_h[0] represents hash of empty prefix, which is 0.
        current_pref_h1[0] = 0;
        current_pref_h2[0] = 0;
        for (int k = 0; k < len; ++k) {
            long long char_val = current_word[k] - 'a' + 1; // 1-based char value to avoid issues with 'a' having value 0
            current_pref_h1[k+1] = (current_pref_h1[k] * P1 + char_val) % M1;
            current_pref_h2[k+1] = (current_pref_h2[k] * P2 + char_val) % M2;
        }

        // 2. Iterate through all possible lengths L for prefix/suffix
        for (int L = 1; L <= len; ++L) {
            // Get hash for prefix of length L: current_word[0...L-1]
            // This is simply current_pref_h1[L] since current_pref_h1[0] is 0
            long long pref_h1 = current_pref_h1[L];
            long long pref_h2 = current_pref_h2[L];

            // Get hash for suffix of length L: current_word[len-L...len-1]
            // hash(s[start...end]) = (hash(s[0...end]) - hash(s[0...start-1]) * P^length_sub + M) % M
            long long suff_h1 = (current_pref_h1[len] - (current_pref_h1[len-L] * powP1[L]) % M1 + M1) % M1;
            long long suff_h2 = (current_pref_h2[len] - (current_pref_h2[len-L] * powP2[L]) % M2 + M2) % M2;

            if (pref_h1 == suff_h1 && pref_h2 == suff_h2) {
                // The prefix of length L is equal to the suffix of length L
                // This means current_word[0...L-1] is a candidate string
                // We need to check how many times this candidate string has appeared before (words[i] where i < j)
                long long combined_hash = (pref_h1 << 32) | pref_h2;
                total_pairs += getHashMap(freq_map, combined_hash);
            }
        }

        // 3. Add the current_word's full hash to the frequency map
        // The full word hash is simply current_pref_h1[len]
        long long current_word_full_h1 = current_pref_h1[len];
        long long current_word_full_h2 = current_pref_h2[len];
        long long current_word_combined_hash = (current_word_full_h1 << 32) | current_word_full_h2;
        insertHashMap(freq_map, current_word_combined_hash, getHashMap(freq_map, current_word_combined_hash) + 1);
    }

    freeHashMap(freq_map);
    return total_pairs;
}