#include <string.h> // For strlen, memset
#include <stdlib.h> // For malloc, free

typedef struct HashEntry {
    unsigned long long hash_val;
    int count;
    struct HashEntry *next;
} HashEntry;

#define TABLE_SIZE 100003 // A prime number for better distribution
static HashEntry *hash_table[TABLE_SIZE];

static unsigned int get_bucket_index(unsigned long long hash_val) {
    return hash_val % TABLE_SIZE;
}

static HashEntry* find_entry(unsigned long long hash_val) {
    unsigned int index = get_bucket_index(hash_val);
    HashEntry *entry = hash_table[index];
    while (entry != NULL) {
        if (entry->hash_val == hash_val) {
            return entry;
        }
        entry = entry->next;
    }
    return NULL;
}

static void insert_entry(unsigned long long hash_val) {
    HashEntry *entry = find_entry(hash_val);
    if (entry != NULL) {
        entry->count++;
    } else {
        entry = (HashEntry*)malloc(sizeof(HashEntry));
        entry->hash_val = hash_val;
        entry->count = 1;
        unsigned int index = get_bucket_index(hash_val);
        entry->next = hash_table[index];
        hash_table[index] = entry;
    }
}

static void free_hash_table() {
    for (int i = 0; i < TABLE_SIZE; i++) {
        HashEntry *entry = hash_table[i];
        while (entry != NULL) {
            HashEntry *temp = entry;
            entry = entry->next;
            free(temp);
        }
        hash_table[i] = NULL; // Reset pointer for next call
    }
}

int maxFreq(char * s, int maxLetters, int minLength, int maxLength){
    // Initialize hash table for each test case as LeetCode might reuse static variables
    memset(hash_table, 0, sizeof(hash_table)); 

    int n = strlen(s);
    if (n < minLength) {
        return 0; // No substrings of required length
    }

    // Rolling hash constants
    long long P = 31; // A prime number greater than 26 (alphabet size)
    long long M = 1e9 + 7; // A large prime modulus

    // Precompute powers of P for rolling hash
    long long *powers = (long long*)malloc(sizeof(long long) * (minLength + 1));
    powers[0] = 1;
    for (int i = 1; i <= minLength; i++) {
        powers[i] = (powers[i-1] * P) % M;
    }

    // Character frequency count for the current window and unique character count
    int char_counts[26];
    int unique_chars_count = 0;
    memset(char_counts, 0, sizeof(char_counts));

    unsigned long long current_hash = 0;
    int max_occurrences = 0;

    // Initialize the first window (s[0 ... minLength - 1])
    for (int j = 0; j < minLength; j++) {
        char c = s[j];
        current_hash = (current_hash * P + (c - 'a' + 1)) % M; // Map 'a' to 1, 'b' to 2, etc.
        if (char_counts[c - 'a'] == 0) {
            unique_chars_count++;
        }
        char_counts[c - 'a']++;
    }

    // Check and store the first window's substring
    if (unique_chars_count <= maxLetters) {
        insert_entry(current_hash);
    }

    // Slide the window
    for (int i = 1; i <= n - minLength; i++) {
        char old_char = s[i-1];
        char new_char = s[i + minLength - 1];

        // Remove old_char from unique count
        char_counts[old_char - 'a']--;
        if (char_counts[old_char - 'a'] == 0) {
            unique_chars_count--;
        }

        // Update hash: remove old_char's contribution
        // (current_hash - (old_char_val * P^(minLength-1))) % M
        current_hash = (current_hash - (unsigned long long)(old_char - 'a' + 1) * powers[minLength - 1]) % M;
        if (current_hash < 0) { // Ensure hash remains positive
            current_hash += M;
        }

        // Add new_char to unique count
        if (char_counts[new_char - 'a'] == 0) {
            unique_chars_count++;
        }
        char_counts[new_char - 'a']++;

        // Update hash: add new_char's contribution
        // (current_hash * P + new_char_val) % M
        current_hash = (current_hash * P + (new_char - 'a' + 1)) % M;

        // Check conditions for the new window's substring
        if (unique_chars_count <= maxLetters) {
            insert_entry(current_hash);
        }
    }

    // Find the maximum occurrence count from the hash table
    for (int i = 0; i < TABLE_SIZE; i++) {
        HashEntry *entry = hash_table[i];
        while (entry != NULL) {
            if (entry->count > max_occurrences) {
                max_occurrences = entry->count;
            }
            entry = entry->next;
        }
    }

    // Free allocated memory
    free(powers);
    free_hash_table(); // This frees all HashEntry structs

    return max_occurrences;
}