#include <stdlib.h> // For malloc, free, strdup, calloc
#include <string.h> // For strlen, strcmp
#include <ctype.h>  // For tolower

typedef struct Entry {
    char *key;
    char *value; // Pointer to the original word from wordlist
    struct Entry *next; // For chaining
} Entry;

#define HASH_TABLE_SIZE 100003 // A prime number for hash table size

static unsigned int string_hash(const char *s) {
    unsigned int hash = 5381;
    int c;
    while ((c = *s++)) {
        hash = ((hash << 5) + hash) + c; 
    }
    return hash % HASH_TABLE_SIZE;
}

static inline int is_vowel_char(char c) {
    c = tolower(c);
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

static char* to_lower_str(const char *s) {
    if (!s) return NULL;
    char *lower_s = (char*)malloc(strlen(s) + 1);
    if (!lower_s) return NULL;
    for (int i = 0; s[i] != '\0'; i++) {
        lower_s[i] = tolower(s[i]);
    }
    lower_s[strlen(s)] = '\0';
    return lower_s;
}

static char* to_devowel_str(const char *s) {
    if (!s) return NULL;
    char *devowel_s = (char*)malloc(strlen(s) + 1);
    if (!devowel_s) {
        return NULL;
    }
    for (int i = 0; s[i] != '\0'; i++) {
        char c = tolower(s[i]);
        if (is_vowel_char(c)) {
            devowel_s[i] = '*';
        } else {
            devowel_s[i] = c;
        }
    }
    devowel_s[strlen(s)] = '\0';
    return devowel_s;
}

static void add_entry(Entry **table, const char *key, const char *value) {
    unsigned int idx = string_hash(key);
    Entry *current = table[idx];

    // Check if key already exists
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return; // Key already exists, do not overwrite (important for first-match rule)
        }
        current = current->next;
    }

    // Add new entry
    Entry *new_entry = (Entry*)malloc(sizeof(Entry));
    new_entry->key = strdup(key); // Key is copied
    new_entry->value = (char*)value; // Value points to existing string (from wordlist)
    new_entry->next = table[idx]; // Prepend to the list
    table[idx] = new_entry;
}

static char* find_entry(Entry **table, const char *key) {
    unsigned int idx = string_hash(key);
    Entry *current = table[idx];
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return current->value;
        }
        current = current->next;
    }
    return NULL; // Not found
}

static void free_hash_table(Entry **table) {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        Entry *current = table[i];
        while (current != NULL) {
            Entry *tmp = current;
            current = current->next;
            free(tmp->key); // Free the key string
            // tmp->value points to original wordlist string, do not free here
            free(tmp);
        }
        table[i] = NULL; // Reset the head of the list
    }
}

char ** spellchecker(char ** wordlist, int wordlistSize, char ** queries, int queriesSize, int* returnSize) {
    // Dynamically allocate hash tables and initialize with NULL
    Entry **exact_words_table = (Entry**)calloc(HASH_TABLE_SIZE, sizeof(Entry*));
    Entry **lower_words_table = (Entry**)calloc(HASH_TABLE_SIZE, sizeof(Entry*));
    Entry **devowel_words_table = (Entry**)calloc(HASH_TABLE_SIZE, sizeof(Entry*));

    if (!exact_words_table || !lower_words_table || !devowel_words_table) {
        if (exact_words_table) free(exact_words_table);
        if (lower_words_table) free(lower_words_table);
        if (devowel_words_table) free(devowel_words_table);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < wordlistSize; i++) {
        const char *word = wordlist[i];

        // 1. Exact match
        add_entry(exact_words_table, word, word);

        // 2. Case-insensitive match
        char *lower_word = to_lower_str(word);
        add_entry(lower_words_table, lower_word, word);
        free(lower_word); // Free the temporary lowercase string

        // 3. Vowel-insensitive match
        char *devowel_word = to_devowel_str(word);
        add_entry(devowel_words_table, devowel_word, word);
        free(devowel_word); // Free the temporary devoweled string
    }

    char **results = (char**)malloc(sizeof(char*) * queriesSize);
    if (!results) {
        *returnSize = 0;
        free_hash_table(exact_words_table);
        free(exact_words_table);
        free_hash_table(lower_words_table);
        free(lower_words_table);
        free_hash_table(devowel_words_table);
        free(devowel_words_table);
        return NULL;
    }
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        const char *query = queries[i];
        char *found_word = NULL;

        // Rule 1: Exact match
        found_word = find_entry(exact_words_table, query);
        if (found_word) {
            results[i] = found_word;
            continue;
        }

        // Rule 2: Case-insensitive match
        char *lower_query = to_lower_str(query);
        found_word = find_entry(lower_words_table, lower_query);
        if (found_word) {
            results[i] = found_word;
            free(lower_query);
            continue;
        }
        free(lower_query); // Free if not found

        // Rule 3: Vowel-insensitive match
        char *devowel_query = to_devowel_str(query);
        found_word = find_entry(devowel_words_table, devowel_query);
        if (found_word) {
            results[i] = found_word;
            free(devowel_query);
            continue;
        }
        free(devowel_query); // Free if not found

        // No match
        results[i] = ""; // Empty string literal
    }

    // Clean up hash tables
    free_hash_table(exact_words_table);
    free(exact_words_table); // Free the array of pointers
    free_hash_table(lower_words_table);
    free(lower_words_table); // Free the array of pointers
    free_hash_table(devowel_words_table);
    free(devowel_words_table); // Free the array of pointers

    return results;
}