#include <stdlib.h> // For malloc, free
#include "uthash.h" // For hash map functionality

typedef struct {
    int key;
    int value; // count
    UT_hash_handle hh; // Makes this structure hashable
} FreqEntry;

FreqEntry *freq_map_global = NULL;

void add_to_map(int key) {
    FreqEntry *entry;
    HASH_FIND_INT(freq_map_global, &key, entry);
    if (entry == NULL) {
        entry = (FreqEntry*)malloc(sizeof(FreqEntry));
        entry->key = key;
        entry->value = 1;
        HASH_ADD_INT(freq_map_global, key, entry);
    } else {
        entry->value++;
    }
}

void remove_from_map(int key) {
    FreqEntry *entry;
    HASH_FIND_INT(freq_map_global, &key, entry);
    if (entry != NULL) {
        entry->value--;
        if (entry->value == 0) {
            HASH_DEL(freq_map_global, entry);
            free(entry);
        }
    }
}

int get_from_map(int key) {
    FreqEntry *entry;
    HASH_FIND_INT(freq_map_global, &key, entry);
    if (entry != NULL) {
        return entry->value;
    }
    return 0;
}

long long countAlmostEqualPairs(int* nums, int numsSize, int k) {
    long long count = 0;

    // Clear the global hash map at the beginning of each test case
    // This is crucial if the function is called multiple times in a single LeetCode run.
    FreqEntry *current_entry, *tmp;
    HASH_ITER(hh, freq_map_global, current_entry, tmp) {
        HASH_DEL(freq_map_global, current_entry);
        free(current_entry);
    }
    freq_map_global = NULL; // Explicitly set to NULL after cleanup

    for (int i = 0; i < numsSize; i++) {
        // At the start of iteration `i`, `freq_map_global` contains counts of `nums[j]`
        // where `j` is in the window `[max(0, i-k), i-1]`.
        // This means it holds elements that can form an almost equal pair with `nums[i]`.

        // 1. Count pairs for `nums[i]` with elements currently in the window.
        // `get_from_map(nums[i])` returns the number of `j`'s such that `nums[j] == nums[i]`
        // and `j` is in `[max(0, i-k), i-1]`.
        count += get_from_map(nums[i]);

        // 2. Add `nums[i]` to the map. This element will be available for future `i'` values
        // (i.e., it becomes part of the window `[i'-k, i'-1]` for `i' > i`).
        add_to_map(nums[i]);

        // 3. Remove the element that falls out of the window for the *next* iteration (`i+1`).
        // For iteration `i+1`, the window will be `[max(0, (i+1)-k), i]`.
        // The element at index `(i-k)` (if `i-k >= 0`) is no longer in this window.
        int idx_to_remove = i - k;
        if (idx_to_remove >= 0) {
            remove_from_map(nums[idx_to_remove]);
        }
    }

    // Clean up the hash map one last time at the end of the function to prevent memory leaks.
    HASH_ITER(hh, freq_map_global, current_entry, tmp) {
        HASH_DEL(freq_map_global, current_entry);
        free(current_entry);
    }
    freq_map_global = NULL; // Explicitly set to NULL after cleanup

    return count;
}