#include <stdlib.h> // For malloc, free

#include "uthash.h"

struct FreqNode {
    int val;
    int count;
    UT_hash_handle hh; // UTHash handle
};

long long maximumSubarraySum(int* nums, int numsSize, int m, int k) {
    struct FreqNode *freq_map = NULL; // Head of the hash map
    long long current_sum = 0;
    long long max_sum = 0;
    int distinct_count = 0; // Manually track the count of distinct elements

    // Helper function to add an element to the frequency map
    // and update current_sum and distinct_count
    // This function is defined inside the main function to capture `freq_map`, `current_sum`, `distinct_count`
    // It's a GCC extension (nested functions) but commonly works on LeetCode.
    // Alternatively, these could be passed as pointers or made global/static if strict C99 is required.
    void add_element(int num) {
        struct FreqNode *s;
        HASH_FIND_INT(freq_map, &num, s); // Try to find the element
        if (s == NULL) {
            // Element not found, create a new node
            s = (struct FreqNode*)malloc(sizeof(struct FreqNode));
            s->val = num;
            s->count = 1;
            HASH_ADD_INT(freq_map, val, s); // Add to hash map
            distinct_count++; // Increment distinct count
        } else {
            // Element found, just increment its count
            s->count++;
        }
        current_sum += num; // Add to current sum
    }

    // Helper function to remove an element from the frequency map
    // and update current_sum and distinct_count
    void remove_element(int num) {
        struct FreqNode *s;
        HASH_FIND_INT(freq_map, &num, s); // Find the element
        // It must be found if it was part of the window
        s->count--; // Decrement its count
        if (s->count == 0) {
            // If count becomes 0, remove from hash map and free memory
            HASH_DEL(freq_map, s);
            free(s);
            distinct_count--; // Decrement distinct count
        }
        current_sum -= num; // Subtract from current sum
    }

    // Initialize the first window of size k
    for (int i = 0; i < k; i++) {
        add_element(nums[i]);
    }

    // Check the first window
    if (distinct_count >= m) {
        max_sum = current_sum;
    }

    // Slide the window through the rest of the array
    for (int i = k; i < numsSize; i++) {
        // Remove the element that is leaving the window (at index i - k)
        remove_element(nums[i - k]);

        // Add the new element entering the window (at index i)
        add_element(nums[i]);

        // Check the current window
        if (distinct_count >= m) {
            if (current_sum > max_sum) {
                max_sum = current_sum;
            }
        }
    }

    // Clean up any remaining nodes in the hash map to prevent memory leaks
    struct FreqNode *current_node, *tmp;
    HASH_ITER(hh, freq_map, current_node, tmp) {
        HASH_DEL(freq_map, current_node);
        free(current_node);
    }

    return max_sum;
}