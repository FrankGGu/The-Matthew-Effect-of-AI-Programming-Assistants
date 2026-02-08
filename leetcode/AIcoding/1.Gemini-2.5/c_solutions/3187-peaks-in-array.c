#include <stdlib.h>
#include <stdbool.h>

int* nums_arr_global;
int* seg_tree_global;
int* peak_flags_global; // Stores 1 if index i is a peak, 0 otherwise
int N_GLOBAL;           // Size of the original array nums

bool is_peak_func(int idx, int n) {
    // An element cannot be a peak if it's the first or last element
    if (idx <= 0 || idx >= n - 1) {
        return false;
    }
    // Check if it's greater than both its neighbors
    return nums_arr_global[idx] > nums_arr_global[idx - 1] && nums_arr_global[idx] > nums_arr_global[idx + 1];
}

void build_seg_tree(int node, int start, int end, int n_original) {
    if (start == end) {
        // Leaf node: calculate peak status for this index
        peak_flags_global[start] = is_peak_func(start, n_original) ? 1 : 0;
        seg_tree_global[node] = peak_flags_global[start];
    } else {
        int mid = start + (end - start) / 2;
        build_seg_tree(2 * node, start, mid, n_original);
        build_seg_tree(2 * node + 1, mid + 1, end, n_original);
        // Internal node: sum of children's peak counts
        seg_tree_global[node] = seg_tree_global[2 * node] + seg_tree_global[2 * node + 1];
    }
}

void update_seg_tree(int node, int start, int end, int idx, int n_original) {
    if (start == end) {
        // Leaf node: recalculate peak status for idx
        peak_flags_global[idx] = is_peak_func(idx, n_original) ? 1 : 0;
        seg_tree_global[node] = peak_flags_global[idx];
    } else {
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update_seg_tree(2 * node, start, mid, idx, n_original);
        } else {
            update_seg_tree(2 * node + 1, mid + 1, end, idx, n_original);
        }
        // Update internal node sum
        seg_tree_global[node] = seg_tree_global[2 * node] + seg_tree_global[2 * node + 1];
    }
}

int query_seg_tree(int node, int start, int end, int l, int r) {
    // If the current segment is completely outside the query range
    if (r < start || end < l) {
        return 0;
    }
    // If the current segment is completely within the query range
    if (l <= start && end <= r) {
        return seg_tree_global[node];
    }
    // Partially overlapping, recurse on children
    int mid = start + (end - start) / 2;
    int p1 = query_seg_tree(2 * node, start, mid, l, r);
    int p2 = query_seg_tree(2 * node + 1, mid + 1, end, l, r);
    return p1 + p2;
}

int* solution(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    N_GLOBAL = numsSize;

    // Allocate memory for global arrays
    nums_arr_global = (int*)malloc(numsSize * sizeof(int));
    seg_tree_global = (int*)malloc(4 * numsSize * sizeof(int)); // Segment tree can take up to 4*N space
    peak_flags_global = (int*)malloc(numsSize * sizeof(int));

    // Copy initial nums values to the global array
    for (int i = 0; i < numsSize; ++i) {
        nums_arr_global[i] = nums[i];
    }

    // Build the segment tree initially
    build_seg_tree(1, 0, numsSize - 1, numsSize);

    // Prepare results array for query type 2 operations
    int* results = (int*)malloc(queriesSize * sizeof(int)); // Max possible results
    *returnSize = 0;

    for (int i = 0; i < queriesSize; ++i) {
        int type = queries[i][0];

        if (type == 1) { // Update query: [1, index, val]
            int idx_1_based = queries[i][1];
            int val = queries[i][2];
            int idx_0_based = idx_1_based - 1; // Convert to 0-based index

            // Store old peak statuses for affected indices (idx-1, idx, idx+1)
            // Need to check bounds before calling is_peak_func to avoid out-of-bounds access
            bool old_is_peak_idx_minus_1 = false;
            if (idx_0_based - 1 >= 0) {
                old_is_peak_idx_minus_1 = is_peak_func(idx_0_based - 1, numsSize);
            }

            bool old_is_peak_idx = is_peak_func(idx_0_based, numsSize);

            bool old_is_peak_idx_plus_1 = false;
            if (idx_0_based + 1 < numsSize) {
                old_is_peak_idx_plus_1 = is_peak_func(idx_0_based + 1, numsSize);
            }

            // Update the value in the global nums array
            nums_arr_global[idx_0_based] = val;

            // Recalculate new peak statuses and update segment tree if status changed
            if (idx_0_based - 1 >= 0) {
                bool new_is_peak_idx_minus_1 = is_peak_func(idx_0_based - 1, numsSize);
                if (old_is_peak_idx_minus_1 != new_is_peak_idx_minus_1) {
                    update_seg_tree(1, 0, numsSize - 1, idx_0_based - 1, numsSize);
                }
            }

            bool new_is_peak_idx = is_peak_func(idx_0_based, numsSize);
            if (old_is_peak_idx != new_is_peak_idx) {
                update_seg_tree(1, 0, numsSize - 1, idx_0_based, numsSize);
            }

            if (idx_0_based + 1 < numsSize) {
                bool new_is_peak_idx_plus_1 = is_peak_func(idx_0_based + 1, numsSize);
                if (old_is_peak_idx_plus_1 != new_is_peak_idx_plus_1) {
                    update_seg_tree(1, 0, numsSize - 1, idx_0_based + 1, numsSize);
                }
            }

        } else { // Query type 2: [2, left, right]
            int left_1_based = queries[i][1];
            int right_1_based = queries[i][2];
            int left_0_based = left_1_based - 1;   // Convert to 0-based
            int right_0_based = right_1_based - 1; // Convert to 0-based

            // Query segment tree for the sum of peaks in the specified range
            int count = query_seg_tree(1, 0, numsSize - 1, left_0_based, right_0_based);
            results[(*returnSize)++] = count;
        }
    }

    // Free the globally allocated memory
    free(nums_arr_global);
    free(seg_tree_global);
    free(peak_flags_global);

    return results;
}