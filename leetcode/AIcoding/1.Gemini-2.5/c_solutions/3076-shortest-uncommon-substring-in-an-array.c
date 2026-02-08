#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <uthash.h>

typedef struct {
    char* key;         // The substring itself
    int count;         // Number of times it appears as a substring
    UT_hash_handle hh; // Makes this structure hashable
} SubstringCount;

SubstringCount* substring_counts_map = NULL;

char* my_strndup(const char* s, size_t n) {
    char* p = (char*)malloc(n + 1);
    if (p == NULL) return NULL;
    strncpy(p, s, n);
    p[n] = '\0';
    return p;
}

void add_substring_to_map(char* sub_key) {
    SubstringCount* s;
    HASH_FIND_STR(substring_counts_map, sub_key, s);
    if (s == NULL) {
        s = (SubstringCount*)malloc(sizeof(*s));
        s->key = sub_key; // Take ownership of the allocated sub_key
        s->count = 1;
        HASH_ADD_STR(substring_counts_map, key, s);
    } else {
        // If key already exists, increment count.
        // The `sub_key` passed in is a duplicate string, so free it.
        free(sub_key);
        s->count++;
    }
}

int get_substring_count_from_map(const char* sub_key) {
    SubstringCount* s;
    HASH_FIND_STR(substring_counts_map, sub_key, s);
    return (s == NULL) ? 0 : s->count;
}

void free_substring_counts_map() {
    SubstringCount* current_item, *tmp;
    HASH_ITER(hh, substring_counts_map, current_item, tmp) {
        HASH_DEL(substring_counts_map, current_item);
        free(current_item->key); // Free the stored key string
        free(current_item);      // Free the struct itself
    }
    substring_counts_map = NULL;
}

char** shortestUncommonSubstrings(char** strs, int strsSize, int* returnSize) {
    // 1. Build the global hash map of all substrings and their counts
    substring_counts_map = NULL; // Ensure it's clean for each call

    for (int i = 0; i < strsSize; i++) {
        int len_s = strlen(strs[i]);
        for (int j = 0; j < len_s; j++) { // Start index of substring
            for (int k = j; k < len_s; k++) { // End index of substring (inclusive)
                int sub_len = k - j + 1;
                char* sub = my_strndup(strs[i] + j, sub_len);
                add_substring_to_map(sub);
            }
        }
    }

    // 2. For each string strs[i], find its shortest uncommon substring
    char** result = (char**)malloc(strsSize * sizeof(char*));
    *returnSize = strsSize;

    for (int i = 0; i < strsSize; i++) {
        char* current_best_uncommon_sub = NULL;
        int len_s = strlen(strs[i]);

        for (int len = 1; len <= len_s; len++) { // Substring length
            bool found_uncommon_for_this_len = false;

            for (int j = 0; j <= len_s - len; j++) { // Start index of substring
                char* sub = my_strndup(strs[i] + j, len);

                if (get_substring_count_from_map(sub) == 1) {
                    // This 'sub' is uncommon (appears only once in all strings)
                    found_uncommon_for_this_len = true;

                    if (current_best_uncommon_sub == NULL) {
                        current_best_uncommon_sub = sub; // Take ownership of sub
                    } else if (strlen(current_best_uncommon_sub) == len) {
                        // Current 'sub' has the same length as current_best_uncommon_sub.
                        // Compare lexicographically.
                        if (strcmp(sub, current_best_uncommon_sub) < 0) {
                            free(current_best_uncommon_sub);
                            current_best_uncommon_sub = sub;
                        } else {
                            free(sub); // 'sub' is not lexicographically smaller, free it
                        }
                    } else { // strlen(current_best_uncommon_sub) < len
                             // A shorter uncommon substring was already found in a previous 'len' iteration.
                             // So current 'sub' (of length 'len') cannot be better.
                        free(sub); // 'sub' is longer, free it
                    }
                } else {
                    free(sub); // Not uncommon, free it
                }
            }

            // Optimization: If we found any uncommon substring of the current length 'len',
            // then 'len' is the shortest possible length. We have already selected
            // the lexicographically smallest among them in the inner loop.
            // So we can break from the length loop for this strs[i].
            if (found_uncommon_for_this_len && current_best_uncommon_sub != NULL && strlen(current_best_uncommon_sub) == len) {
                break;
            }
        }

        // If no uncommon substring was found, current_best_uncommon_sub remains NULL.
        // In this case, we need to store an empty string.
        if (current_best_uncommon_sub == NULL) {
            result[i] = (char*)malloc(sizeof(char));
            result[i][0] = '\0';
        } else {
            result[i] = current_best_uncommon_sub;
        }
    }

    // 3. Clean up the hash table and its contents
    free_substring_counts_map();

    return result;
}