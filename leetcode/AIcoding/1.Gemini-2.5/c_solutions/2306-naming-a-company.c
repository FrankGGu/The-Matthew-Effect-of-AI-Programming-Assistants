#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct Entry {
    char* key;
    struct Entry* next;
} Entry;

typedef struct {
    Entry** table;
    int capacity;
    int size;
} StringHashSet;

unsigned long hash_string(const char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    return hash;
}

StringHashSet* create_hash_set(int capacity) {
    StringHashSet* set = (StringHashSet*)malloc(sizeof(StringHashSet));
    set->capacity = capacity;
    set->size = 0;
    set->table = (Entry**)calloc(capacity, sizeof(Entry*));
    return set;
}

void add_to_hash_set(StringHashSet* set, const char* key) {
    unsigned long index = hash_string(key) % set->capacity;
    Entry* current = set->table[index];
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return; // Key already exists
        }
        current = current->next;
    }

    Entry* new_entry = (Entry*)malloc(sizeof(Entry));
    new_entry->key = strdup(key); // Duplicate the string
    new_entry->next = set->table[index];
    set->table[index] = new_entry;
    set->size++;
}

bool contains_in_hash_set(StringHashSet* set, const char* key) {
    unsigned long index = hash_string(key) % set->capacity;
    Entry* current = set->table[index];
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return true;
        }
        current = current->next;
    }
    return false;
}

int get_hash_set_size(StringHashSet* set) {
    return set->size;
}

void free_hash_set(StringHashSet* set) {
    for (int i = 0; i < set->capacity; i++) {
        Entry* current = set->table[i];
        while (current != NULL) {
            Entry* temp = current;
            current = current->next;
            free(temp->key); // Free duplicated string
            free(temp);
        }
    }
    free(set->table);
    free(set);
}

long long distinctNames(char **ideas, int ideasSize) {
    StringHashSet* sets[26];

    // Choose a sufficiently large prime capacity for hash sets to minimize collisions.
    // Max ideasSize is 5 * 10^4. A capacity around 20000-50000 for each set is reasonable.
    // 20003 is a prime number.
    int hash_set_capacity = 20003; 

    for (int i = 0; i < 26; i++) {
        sets[i] = create_hash_set(hash_set_capacity);
    }

    for (int i = 0; i < ideasSize; i++) {
        char* idea = ideas[i];
        int first_char_idx = idea[0] - 'a';
        add_to_hash_set(sets[first_char_idx], idea + 1); // Add suffix (string starting from second char)
    }

    long long ans = 0;

    for (int i = 0; i < 25; i++) {
        for (int j = i + 1; j < 26; j++) {
            int common_count = 0;

            // Iterate through suffixes in sets[i] and check if they exist in sets[j]
            for (int k = 0; k < sets[i]->capacity; k++) {
                Entry* current = sets[i]->table[k];
                while (current != NULL) {
                    if (contains_in_hash_set(sets[j], current->key)) {
                        common_count++;
                    }
                    current = current->next;
                }
            }

            // Number of suffixes unique to sets[i] (not in sets[j])
            long long unique_i = get_hash_set_size(sets[i]) - common_count;
            // Number of suffixes unique to sets[j] (not in sets[i])
            long long unique_j = get_hash_set_size(sets[j]) - common_count;

            ans += unique_i * unique_j;
        }
    }

    // Free allocated memory for hash sets
    for (int i = 0; i < 26; i++) {
        free_hash_set(sets[i]);
    }

    // Each pair (suffix_i, suffix_j) can be combined in two ways:
    // (char_i + suffix_j, char_j + suffix_i) and (char_j + suffix_i, char_i + suffix_j)
    // The problem asks for ordered pairs, so we multiply by 2.
    return ans * 2;
}