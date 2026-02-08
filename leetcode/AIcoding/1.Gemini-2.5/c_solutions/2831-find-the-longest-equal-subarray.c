#include <stdlib.h> // For malloc, realloc, free, exit
#include "uthash.h" // For hash map functionality

typedef struct {
    int key;         // The number itself
    int* indices;    // Dynamic array of indices where this number appears
    int count;       // Current number of indices stored
    int capacity;    // Current capacity of the indices array
    UT_hash_handle hh; // Makes this structure hashable by uthash
} FreqIndicesEntry;

FreqIndicesEntry *g_freq_indices_map = NULL;

void add_index(FreqIndicesEntry *entry, int index) {
    if (entry->count == entry->capacity) {
        // Double capacity if needed. Start with a small capacity if 0.
        entry->capacity = (entry->capacity == 0) ? 4 : entry->capacity * 2;
        entry->indices = (int*)realloc(entry->indices, entry->capacity * sizeof(int));
        // Handle realloc failure
        if (entry->indices == NULL) {
            exit(EXIT_FAILURE); // Out of memory
        }
    }
    entry->indices[entry->count++] = index;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int longestEqualSubarray(int* nums, int numsSize, int k) {
    // Clear the global hash map from previous test cases
    FreqIndicesEntry *current_entry, *tmp;
    HASH_ITER(hh, g_freq_indices_map, current_entry, tmp) {
        HASH_DEL(g_freq_indices_map, current_entry);
        free(current_entry->indices);
        free(current_entry);
    }
    g_freq_indices_map = NULL; // Reset map pointer

    // First pass: Populate the hash map with all indices for each unique number
    for (int i = 0; i < numsSize; i++) {
        FreqIndicesEntry *entry;
        HASH_FIND_INT(g_freq_indices_map, &nums[i], entry);
        if (entry == NULL) {
            // If number not found, create a new entry
            entry = (FreqIndicesEntry*)malloc(sizeof(FreqIndicesEntry));
            if (entry == NULL) exit(EXIT_FAILURE); // Handle malloc failure
            entry->key = nums[i];
            entry->indices = NULL; // Will be allocated by add_index
            entry->count = 0;
            entry->capacity = 0;
            HASH_ADD_INT(g_freq_indices_map, key, entry);
        }
        add_index(entry, i);
    }

    int max_len = 0;

    // Second pass: Iterate through each unique number's indices and apply sliding window
    HASH_ITER(hh, g_freq_indices_map, current_entry, tmp) {
        int *indices = current_entry->indices;
        int count = current_entry->count;

        // Sliding window pointers for the 'indices' array
        int left_idx_ptr = 0;
        for (int right_idx_ptr = 0; right_idx_ptr < count; right_idx_ptr++) {
            // Calculate the number of elements that are NOT the target number
            // within the original array segment from indices[left_idx_ptr] to indices[right_idx_ptr].
            // This is (total length of subarray) - (count of target number in subarray).
            // Total length = indices[right_idx_ptr] - indices[left_idx_ptr] + 1
            // Count of target number = right_idx_ptr - left_idx_ptr + 1
            // Deletions needed = (indices[right_idx_ptr] - indices[left_idx_ptr] + 1) - (right_idx_ptr - left_idx_ptr + 1)
            //                  = indices[right_idx_ptr] - indices[left_idx_ptr] - (right_idx_ptr - left_idx_ptr)
            while ((indices[right_idx_ptr] - indices[left_idx_ptr]) - (right_idx_ptr - left_idx_ptr) > k) {
                left_idx_ptr++;
            }

            // The current window [indices[left_idx_ptr] ... indices[right_idx_ptr]] is valid.
            // The length of the original subarray is indices[right_idx_ptr] - indices[left_idx_ptr] + 1.
            max_len = max(max_len, indices[right_idx_ptr] - indices[left_idx_ptr] + 1);
        }
    }

    // All memory associated with g_freq_indices_map has already been freed
    // by the initial clearing loop at the beginning of the function.
    // g_freq_indices_map is also set to NULL.

    return max_len;
}