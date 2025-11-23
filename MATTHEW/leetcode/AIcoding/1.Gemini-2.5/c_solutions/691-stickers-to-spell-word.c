#include <string.h>
#include <stdlib.h>
#include <stdio.h> // Required for NULL, potentially for debugging, but not strictly for the core logic
#include "uthash.h" // Assuming uthash.h is available or provided by the environment

typedef struct {
    char target_counts_key[26]; // Key: character counts for the remaining target
    int min_stickers;
    UT_hash_handle hh;
} MemoEntry;

MemoEntry *memo = NULL;

int **g_sticker_counts;
int g_stickers_size;

void get_char_counts_int(const char *s, int *counts) {
    memset(counts, 0, sizeof(int) * 26);
    for (int i = 0; s[i] != '\0'; i++) {
        counts[s[i] - 'a']++;
    }
}

void convert_int_to_char_counts(int *int_counts, char *char_counts_key) {
    for (int i = 0; i < 26; i++) {
        char_counts_key[i] = (char)int_counts[i];
    }
}

int solve_recursive(char *current_target_str) {
    if (current_target_str[0] == '\0') {
        return 0;
    }

    int target_char_counts_int[26];
    get_char_counts_int(current_target_str, target_char_counts_int);

    char target_char_counts_key[26];
    convert_int_to_char_counts(target_char_counts_int, target_char_counts_key);

    MemoEntry *entry;
    HASH_FIND(hh, memo, target_char_counts_key, sizeof(char) * 26, entry);
    if (entry) {
        return entry->min_stickers;
    }

    int res = -1; // Use -1 to represent INT_MAX, as 0 is a valid answer.

    // Optimization: Find the first character needed in the target
    // Any sticker used must contain this character to be considered for this current target state.
    int first_char_code = -1;
    for(int i = 0; i < 26; ++i) {
        if (target_char_counts_int[i] > 0) {
            first_char_code = i;
            break;
        }
    }
    // If first_char_code is still -1, it means current_target_str was empty,
    // but we already handled that case at the beginning.

    for (int i = 0; i < g_stickers_size; i++) {
        int *current_sticker_counts = g_sticker_counts[i];

        // Pruning: If the sticker doesn't contain the first needed character, skip it.
        if (current_sticker_counts[first_char_code] == 0) {
            continue;
        }

        int temp_target_counts[26];
        memcpy(temp_target_counts, target_char_counts_int, sizeof(int) * 26);

        // Apply sticker to target counts
        // This loop ensures we use as many characters from the sticker as possible
        // to satisfy the target's needs.
        int target_changed = 0;
        for (int j = 0; j < 26; j++) {
            if (current_sticker_counts[j] > 0 && temp_target_counts[j] > 0) {
                int take = current_sticker_counts[j];
                if (take > temp_target_counts[j]) {
                    take = temp_target_counts[j];
                }
                temp_target_counts[j] -= take;
                if (take > 0) {
                    target_changed = 1;
                }
            }
        }

        // If the sticker didn't help reduce the target at all, skip this path.
        if (!target_changed) {
            continue;
        }

        // Reconstruct the new target string from `temp_target_counts`
        // This string will be passed to the next recursive call.
        // It needs to be sorted to ensure canonical representation for memoization.
        int len = 0;
        for (int j = 0; j < 26; j++) {
            len += temp_target_counts[j];
        }
        char *new_target_str = (char*)malloc(sizeof(char) * (len + 1));
        int k = 0;
        for (int j = 0; j < 26; j++) {
            for (int l = 0; l < temp_target_counts[j]; l++) {
                new_target_str[k++] = (char)('a' + j);
            }
        }
        new_target_str[k] = '\0';

        int sub_res = solve_recursive(new_target_str);
        free(new_target_str); // Free the dynamically allocated string

        if (sub_res != -1) {
            if (res == -1 || 1 + sub_res < res) {
                res = 1 + sub_res;
            }
        }
    }

    entry = (MemoEntry*)malloc(sizeof(MemoEntry));
    memcpy(entry->target_counts_key, target_char_counts_key, sizeof(char) * 26);
    entry->min_stickers = res;
    HASH_ADD(hh, memo, target_counts_key, sizeof(char) * 26, entry);

    return res;
}

int minStickers(char **stickers, int stickersSize, char *target) {
    // Initialize global variables
    g_stickers_size = stickersSize;
    g_sticker_counts = (int**)malloc(sizeof(int*) * stickersSize);
    for (int i = 0; i < stickersSize; i++) {
        g_sticker_counts[i] = (int*)malloc(sizeof(int) * 26);
        get_char_counts_int(stickers[i], g_sticker_counts[i]);
    }

    // Pre-process target to get its canonical string representation
    // This is the initial state for the recursive function.
    int target_initial_counts[26];
    get_char_counts_int(target, target_initial_counts);
    int len = 0;
    for (int j = 0; j < 26; j++) {
        len += target_initial_counts[j];
    }
    char *canonical_target = (char*)malloc(sizeof(char) * (len + 1));
    int k = 0;
    for (int j = 0; j < 26; j++) {
        for (int l = 0; l < target_initial_counts[j]; l++) {
            canonical_target[k++] = (char)('a' + j);
        }
    }
    canonical_target[k] = '\0';

    // Clear memoization table for new test cases (important for LeetCode's multiple test cases)
    MemoEntry *current_entry, *tmp_entry;
    HASH_ITER(hh, memo, current_entry, tmp_entry) {
        HASH_DEL(memo, current_entry);
        free(current_entry);
    }
    memo = NULL;

    int result = solve_recursive(canonical_target);

    // Clean up global variables
    for (int i = 0; i < stickersSize; i++) {
        free(g_sticker_counts[i]);
    }
    free(g_sticker_counts);
    free(canonical_target);

    return result;
}