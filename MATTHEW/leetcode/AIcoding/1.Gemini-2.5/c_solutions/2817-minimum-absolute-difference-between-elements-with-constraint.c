#include <stdlib.h>
#include <limits.h> // For LLONG_MAX

long long custom_abs(long long a) {
    return a < 0 ? -a : a;
}

typedef struct {
    int val;
} ValueEntry;

int compare_values(const void *a, const void *b) {
    return ((ValueEntry *)a)->val - ((ValueEntry *)b)->val;
}

int lower_bound_idx(ValueEntry *arr, int size, int target) {
    int low = 0;
    int high = size - 1;
    int ans = size; // Default to size if all elements are less than target

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid].val >= target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int *segment_tree;
int unique_values_count_global; // Stores the total count of unique values for segment tree range

void build_segment_tree(int n_unique) {
    unique_values_count_global = n_unique;
    // Max size of segment tree is 4 * N for N leaves
    segment_tree = (int *)calloc(4 * n_unique, sizeof(int)); // Initialize with 0
}

void update_segment_tree(int node, int start, int end, int idx, int val) {
    if (start == end) {
        segment_tree[node] = val;
        return;
    }
    int mid = start + (end - start) / 2;
    if (idx <= mid) { // If idx is in the left child's range
        update_segment_tree(2 * node, start, mid, idx, val);
    } else { // If idx is in the right child's range
        update_segment_tree(2 * node + 1, mid + 1, end, idx, val);
    }
    // Combine results from children: 1 if any child has an element, 0 otherwise
    segment_tree[node] = segment_tree[2 * node] | segment_tree[2 * node + 1];
}

int query_floor_segment_tree(int node, int start, int end, int target_idx_compressed) {
    if (segment_tree[node] == 0) { // No elements present in this range
        return -1;
    }
    if (start == end) { // Leaf node, and it's present (due to segment_tree[node] == 1)
        return start;
    }

    int mid = start + (end - start) / 2;
    int res = -1;

    // Try finding in the right child first if target allows (target is in right half or beyond mid)
    if (target_idx_compressed > mid) {
        res = query_floor_segment_tree(2 * node + 1, mid + 1, end, target_idx_compressed);
        if (res != -1) {
            return res; // Found in right child
        }
    }
    // If not found in right child (or target was in left child range), try left child
    return query_floor_segment_tree(2 * node, start, mid, target_idx_compressed);
}

int query_ceil_segment_tree(int node, int start, int end, int target_idx_compressed) {
    if (segment_tree[node] == 0) { // No elements present in this range
        return -1;
    }
    if (start == end) { // Leaf node, and it's present (due to segment_tree[node] == 1)
        return start;
    }

    int mid = start + (end - start) / 2;
    int res = -1;

    // Try finding in the left child first if target allows (target is in left half or exactly mid)
    if (target_idx_compressed <= mid) {
        res = query_ceil_segment_tree(2 * node, start, mid, target_idx_compressed);
        if (res != -1) {
            return res; // Found in left child
        }
    }
    // If not found in left child (or target was in right child range), try right child
    return query_ceil_segment_tree(2 * node + 1, mid + 1, end, target_idx_compressed);
}

int minAbsoluteDifference(int* nums, int numsSize, int x) {
    // 1. Coordinate Compression: Collect all numbers, sort, and remove duplicates
    ValueEntry *all_values = (ValueEntry *)malloc(numsSize * sizeof(ValueEntry));
    for (int i = 0; i < numsSize; ++i) {
        all_values[i].val = nums[i];
    }
    qsort(all_values, numsSize, sizeof(ValueEntry), compare_values);

    ValueEntry *unique_values = (ValueEntry *)malloc(numsSize * sizeof(ValueEntry));
    int current_unique_count = 0;
    if (numsSize > 0) {
        unique_values[current_unique_count++] = all_values[0];
        for (int i = 1; i < numsSize; ++i) {
            if (all_values[i].val != all_values[i-1].val) {
                unique_values[current_unique_count++] = all_values[i];
            }
        }
    }
    free(all_values); // Free temporary array

    // 2. Initialize Segment Tree with the range of compressed indices
    build_segment_tree(current_unique_count);

    long long min_abs_diff = LLONG_MAX;

    // 3. Iterate through nums array
    for (int j = 0; j < numsSize; ++j) {
        // Add nums[j-x] to the segment tree if j is far enough
        if (j >= x) {
            int val_to_add = nums[j - x];
            int compressed_idx_to_add = lower_bound_idx(unique_values, current_unique_count, val_to_add);
            update_segment_tree(1, 0, unique_values_count_global - 1, compressed_idx_to_add, 1);
        }

        // If there are elements in the segment tree (i.e., j >= x and some elements added)
        // Query for the closest element to nums[j] among the candidates
        if (j >= x && segment_tree[1] == 1) { // Check if root has any elements marked present
            int target_val = nums[j];
            int target_compressed_idx = lower_bound_idx(unique_values, current_unique_count, target_val);

            // Find floor: largest element <= target_val
            int floor_compressed_idx = query_floor_segment_tree(1, 0, unique_values_count_global - 1, target_compressed_idx);
            if (floor_compressed_idx != -1) {
                long long diff = custom_abs((long long)target_val - unique_values[floor_compressed_idx].val);
                if (diff < min_abs_diff) {
                    min_abs_diff = diff;
                }
            }

            // Find ceil: smallest element >= target_val
            int ceil_compressed_idx = query_ceil_segment_tree(1, 0, unique_values_count_global - 1, target_compressed_idx);
            if (ceil_compressed_idx != -1) {
                long long diff = custom_abs((long long)target_val - unique_values[ceil_compressed_idx].val);
                if (diff < min_abs_diff) {
                    min_abs_diff = diff;
                }
            }
        }
    }

    // Clean up allocated memory
    free(unique_values);
    free(segment_tree);

    return (int)min_abs_diff;
}