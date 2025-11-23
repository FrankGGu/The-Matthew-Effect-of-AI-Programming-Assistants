#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool type

long long max(long long a, long long b) {
    return a > b ? a : b;
}

int* parent_dsu;
long long* segment_sum_dsu;

int find(int i) {
    if (parent_dsu[i] == i) {
        return i;
    }
    return parent_dsu[i] = find(parent_dsu[i]);
}

void union_sets(int root_i, int root_j) {
    if (root_i != root_j) {
        parent_dsu[root_j] = root_i;
        segment_sum_dsu[root_i] += segment_sum_dsu[root_j];
    }
}

long long* maximumSegmentSum(int* nums, int numsSize, int* removals, int removalsSize, int* returnSize) {
    *returnSize = removalsSize;
    long long* ans = (long long*)malloc(sizeof(long long) * removalsSize);
    if (!ans) return NULL;

    // Allocate memory for DSU structures and availability tracker
    parent_dsu = (int*)malloc(sizeof(int) * numsSize);
    segment_sum_dsu = (long long*)malloc(sizeof(long long) * numsSize);
    bool* is_available = (bool*)malloc(sizeof(bool) * numsSize);

    // Check for allocation failures
    if (!parent_dsu || !segment_sum_dsu || !is_available) {
        free(ans);
        if (parent_dsu) free(parent_dsu);
        if (segment_sum_dsu) free(segment_sum_dsu);
        if (is_available) free(is_available);
        return NULL;
    }

    // Initialize DSU: each element is its own set, sum is its own value
    // Initialize all elements as unavailable
    for (int i = 0; i < numsSize; ++i) {
        parent_dsu[i] = i;
        segment_sum_dsu[i] = nums[i];
        is_available[i] = false;
    }

    long long current_max_segment_sum = 0;

    // Process removals in reverse order (effectively adding elements back)
    for (int k = removalsSize - 1; k >= 0; --k) {
        int idx = removals[k];

        // The maximum segment sum *before* adding nums[idx] back
        ans[k] = current_max_segment_sum; 

        // Mark current element as available
        is_available[idx] = true;

        // The element itself forms a segment, update max if it's greater
        current_max_segment_sum = max(current_max_segment_sum, (long long)nums[idx]);

        // Check left neighbor for merging
        if (idx > 0 && is_available[idx - 1]) {
            int root_idx = find(idx);
            int root_left = find(idx - 1);
            if (root_idx != root_left) { 
                union_sets(root_idx, root_left);
                // Update max sum with the newly merged segment
                current_max_segment_sum = max(current_max_segment_sum, segment_sum_dsu[find(idx)]);
            }
        }

        // Check right neighbor for merging
        if (idx < numsSize - 1 && is_available[idx + 1]) {
            // Re-find root for idx, as it might have changed after merging with left neighbor
            int root_idx = find(idx); 
            int root_right = find(idx + 1);
            if (root_idx != root_right) { 
                union_sets(root_idx, root_right);
                // Update max sum with the newly merged segment
                current_max_segment_sum = max(current_max_segment_sum, segment_sum_dsu[find(idx)]);
            }
        }
    }

    // Free allocated memory for DSU structures and availability tracker
    free(parent_dsu);
    free(segment_sum_dsu);
    free(is_available);

    return ans;
}