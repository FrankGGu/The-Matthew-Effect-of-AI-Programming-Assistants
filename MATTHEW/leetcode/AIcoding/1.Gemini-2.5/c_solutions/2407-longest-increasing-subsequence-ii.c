#include <stdlib.h>
#include <string.h>

#define MAX_UNIQUE_VALS 100005 
#define SEG_TREE_SIZE (4 * MAX_UNIQUE_VALS)

int seg_tree[SEG_TREE_SIZE];
int unique_vals[MAX_UNIQUE_VALS];
int unique_count;

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int lower_bound(int* arr, int size, int target) {
    int low = 0;
    int high = size - 1;
    int ans = size; // Default to size if no element meets the condition

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

void build(int node, int start, int end) {
    if (start == end) {
        seg_tree[node] = 0;
    } else {
        int mid = start + (end - start) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        seg_tree[node] = 0; // Max of children, initially 0
    }
}

void update(int node, int start, int end, int idx, int val) {
    if (start == end) {
        seg_tree[node] = (seg_tree[node] > val) ? seg_tree[node] : val;
    } else {
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        // After updating children, update the parent node with the maximum of its children.
        seg_tree[node] = (seg_tree[2 * node] > seg_tree[2 * node + 1]) ? seg_tree[2 * node] : seg_tree[2 * node + 1];
    }
}

int query(int node, int start, int end, int L, int R) {
    // If the query range is completely outside the node's range, return 0 (identity for max).
    if (R < start || end < L) {
        return 0;
    }
    // If the node's range is completely within the query range, return the node's value.
    if (L <= start && end <= R) {
        return seg_tree[node];
    }
    // If there's partial overlap, recursively query children and take the maximum.
    int mid = start + (end - start) / 2;
    int p1 = query(2 * node, start, mid, L, R);
    int p2 = query(2 * node + 1, mid + 1, end, L, R);
    return (p1 > p2) ? p1 : p2;
}

int longestIncreasingSubsequenceII(int* nums, int numsSize, int k) {
    // 1. Coordinate Compression:
    // Create a sorted list of unique values from `nums`. This maps original large values
    // to smaller, contiguous indices for segment tree operations.

    // Copy `nums` to `unique_vals` to prepare for sorting and deduplication.
    memcpy(unique_vals, nums, numsSize * sizeof(int));
    qsort(unique_vals, numsSize, sizeof(int), compareInts);

    // Remove duplicates from `unique_vals`.
    if (numsSize > 0) {
        unique_count = 1;
        for (int i = 1; i < numsSize; ++i) {
            if (unique_vals[i] != unique_vals[i - 1]) {
                unique_vals[unique_count++] = unique_vals[i];
            }
        }
    } else {
        unique_count = 0; // Handle empty input array
    }

    // Initialize the segment tree.
    // The tree will operate on compressed indices from 0 to `unique_count - 1`.
    if (unique_count > 0) {
        build(1, 0, unique_count - 1);
    } else {
        return 0; // If nums is empty, LIS length is 0.
    }

    int max_lis_len = 0;

    // 2. Iterate through `nums` and use the segment tree to find LIS lengths.
    // For each `current_val` in `nums`, we want to find the longest LIS ending
    // with a `prev_val` that satisfies two conditions:
    // a) `prev_val < current_val` (for strictly increasing)
    // b) `current_val - prev_val <= k` (the difference constraint)
    // Combining these: `current_val - k <= prev_val < current_val`.
    for (int i = 0; i < numsSize; ++i) {
        int current_val = nums[i];

        // Get the compressed index for `current_val`.
        int current_idx = lower_bound(unique_vals, unique_count, current_val);

        // Determine the lower bound for `prev_val` in the original value space.
        int query_start_val = current_val - k;
        // Get the compressed index for this lower bound.
        int query_start_idx = lower_bound(unique_vals, unique_count, query_start_val);

        // The upper bound for `prev_val` in compressed indices is `current_idx - 1`,
        // because `prev_val` must be strictly less than `current_val`.
        int query_end_idx = current_idx - 1;

        int prev_max_len = 0;
        // Perform a query on the segment tree to find the maximum LIS length
        // ending at any `prev_val` within the valid compressed index range.
        if (query_start_idx <= query_end_idx) { // Ensure the query range is valid
            prev_max_len = query(1, 0, unique_count - 1, query_start_idx, query_end_idx);
        }

        // The LIS length ending at `current_val` is `prev_max_len + 1`.
        int current_lis_len = prev_max_len + 1;

        // Update the segment tree at `current_idx` with `current_lis_len`.
        // We take the maximum because multiple subsequences might end at the same value.
        update(1, 0, unique_count - 1, current_idx, current_lis_len);

        // Update the overall maximum LIS length found so far.
        if (current_lis_len > max_lis_len) {
            max_lis_len = current_lis_len;
        }
    }

    return max_lis_len;
}