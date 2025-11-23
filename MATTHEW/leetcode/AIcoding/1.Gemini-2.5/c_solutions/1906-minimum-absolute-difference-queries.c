#include <stdlib.h>
#include <string.h> // For memset
#include <limits.h> // For INT_MAX

#define MAX_VAL 100
#define MASK_SIZE ((MAX_VAL / 32) + 1) 

unsigned int tree_mask[4 * 100005][MASK_SIZE];

void clear_mask(unsigned int* mask_arr) {
    memset(mask_arr, 0, sizeof(unsigned int) * MASK_SIZE);
}

void set_bit(unsigned int* mask_arr, int val) {
    mask_arr[val / 32] |= (1U << (val % 32));
}

int get_bit(unsigned int* mask_arr, int val) {
    return (mask_arr[val / 32] >> (val % 32)) & 1U;
}

void or_masks(unsigned int* dest, unsigned int* src1, unsigned int* src2) {
    for (int i = 0; i < MASK_SIZE; ++i) {
        dest[i] = src1[i] | src2[i];
    }
}

void build(int node, int start, int end, int* nums) {
    clear_mask(tree_mask[node]); // Initialize current node's mask to zero
    if (start == end) {
        set_bit(tree_mask[node], nums[start]);
    } else {
        int mid = start + (end - start) / 2; // Prevent overflow for large start+end
        build(2 * node, start, mid, nums);
        build(2 * node + 1, mid + 1, end, nums);
        or_masks(tree_mask[node], tree_mask[2 * node], tree_mask[2 * node + 1]);
    }
}

void query_mask_range(int node, int start, int end, int l, int r, unsigned int* result_mask) {
    if (r < start || end < l) {
        return; // No overlap with query range
    }
    if (l <= start && end <= r) {
        or_masks(result_mask, result_mask, tree_mask[node]); // Complete overlap, OR node's mask into result
        return;
    }
    int mid = start + (end - start) / 2;
    query_mask_range(2 * node, start, mid, l, r, result_mask);
    query_mask_range(2 * node + 1, mid + 1, end, l, r, result_mask);
}

int* minDifference(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Build the segment tree once for all queries
    build(1, 0, numsSize - 1, nums);

    int* results = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    unsigned int current_query_mask[MASK_SIZE]; // Temporary mask for each query

    for (int k = 0; k < queriesSize; ++k) {
        int left = queries[k][0];
        int right = queries[k][1];

        clear_mask(current_query_mask); // Initialize mask for the current query to all zeros
        query_mask_range(1, 0, numsSize - 1, left, right, current_query_mask);

        int min_diff = INT_MAX;
        int last_val = -1; // Stores the last number found in the mask

        // Iterate from 1 to MAX_VAL (100) to find present numbers and their differences
        for (int i = 1; i <= MAX_VAL; ++i) {
            if (get_bit(current_query_mask, i)) {
                if (last_val != -1) { // If a previous number was found
                    if (i - last_val < min_diff) {
                        min_diff = i - last_val;
                    }
                }
                last_val = i; // Update last_val to the current number
            }
        }

        // If min_diff is still INT_MAX, it means there were less than two distinct numbers
        if (min_diff == INT_MAX) {
            results[k] = -1;
        } else {
            results[k] = min_diff;
        }
    }

    return results;
}