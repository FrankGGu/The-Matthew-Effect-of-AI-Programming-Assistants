#include <stdlib.h>
#include <string.h>

typedef struct {
    unsigned long long hash;
    int index;
} HashEntry;

int compareHashEntries(const void *a, const void *b) {
    HashEntry *entryA = (HashEntry *)a;
    HashEntry *entryB = (HashEntry *)b;
    if (entryA->hash < entryB->hash) return -1;
    if (entryA->hash > entryB->hash) return 1;
    return 0;
}

int check(char *s, int n, int len, int *found_idx_ptr) {
    if (len == 0) {
        *found_idx_ptr = 0; // An empty string is always a duplicate at index 0
        return 0;
    }

    // Base for rolling hash (a prime larger than max char value 'z'-'a'+1 = 26)
    unsigned long long base = 31; 

    // Calculate base^(len-1)
    unsigned long long p_pow_len_minus_1 = 1;
    for (int i = 0; i < len - 1; i++) {
        p_pow_len_minus_1 *= base;
    }

    // There are (n - len + 1) possible substrings of length 'len'
    int num_substrings = n - len + 1;
    HashEntry *entries = (HashEntry *)malloc(sizeof(HashEntry) * num_substrings);
    if (entries == NULL) return -1; // Memory allocation failed

    unsigned long long current_hash = 0;
    // Calculate hash for the first substring s[0...len-1]
    for (int i = 0; i < len; i++) {
        current_hash = current_hash * base + (s[i] - 'a' + 1);
    }
    entries[0].hash = current_hash;
    entries[0].index = 0;

    // Calculate hashes for subsequent substrings using rolling hash
    for (int i = 1; i < num_substrings; i++) {
        // Remove hash of s[i-1], shift, add hash of s[i+len-1]
        current_hash = (current_hash - (s[i-1] - 'a' + 1) * p_pow_len_minus_1) * base + (s[i+len-1] - 'a' + 1);
        entries[i].hash = current_hash;
        entries[i].index = i;
    }

    // Sort the hash entries
    qsort(entries, num_substrings, sizeof(HashEntry), compareHashEntries);

    // Check for duplicate hashes in the sorted array
    for (int i = 0; i < num_substrings - 1; i++) {
        if (entries[i].hash == entries[i+1].hash) {
            // Found a duplicate hash. Return its starting index.
            // For robustness, one might add a string comparison here:
            // if (strncmp(s + entries[i].index, s + entries[i+1].index, len) == 0) {
            //     *found_idx_ptr = entries[i].index;
            //     free(entries);
            //     return 0; // Indicate success (found a duplicate)
            // }
            // For typical LeetCode cases, a single unsigned long long hash is often sufficient.
            *found_idx_ptr = entries[i].index;
            free(entries);
            return 0; // Indicate success (found a duplicate)
        }
    }

    free(entries);
    return -1; // No duplicate of this length found
}

char * longestDupSubstring(char * s){
    int n = strlen(s);
    if (n == 0) {
        char *res = (char *)malloc(sizeof(char));
        if (res == NULL) return NULL; 
        res[0] = '\0';
        return res;
    }

    int low = 0, high = n - 1; // Possible lengths of duplicate substring
    int ans_len = 0;
    int ans_idx = 0; // Starting index of the longest duplicate substring

    while (low <= high) {
        int mid = low + (high - low) / 2;
        int current_found_idx = -1;
        if (check(s, n, mid, &current_found_idx) == 0) { // If a duplicate of length 'mid' is found
            ans_len = mid;
            ans_idx = current_found_idx;
            low = mid + 1; // Try to find a longer duplicate
        } else {
            high = mid - 1; // No duplicate of length 'mid' found, try shorter
        }
    }

    // Construct the result string
    char *result = (char *)malloc(sizeof(char) * (ans_len + 1));
    if (result == NULL) return NULL; 

    strncpy(result, s + ans_idx, ans_len);
    result[ans_len] = '\0';

    return result;
}