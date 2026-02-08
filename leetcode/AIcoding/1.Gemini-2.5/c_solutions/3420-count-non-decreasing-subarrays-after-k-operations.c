#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int* unique_nums_global;
int unique_nums_size_global;

int compare_ints(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int get_compressed_idx(int val) {
    int low = 0, high = unique_nums_size_global - 1;
    int ans = -1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (unique_nums_global[mid] == val) {
            ans = mid;
            break;
        } else if (unique_nums_global[mid] < val) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;
}

typedef struct {
    long long max_len;
    long long total_count;
} Node;

Node merge_nodes(Node left, Node right) {
    if (left.total_count > right.total_count) {
        return left;
    } else if (right.total_count > left.total_count) {
        return right;
    } else { // total_count are equal, prioritize max_len
        if (left.max_len > right.max_len) {
            return left;
        } else {
            return right;
        }
    }
}

Node* current_tree; // Global pointer for the current segment tree being operated on
int current_tree_size;

void build_tree(int node_idx, int start, int end) {
    if (start == end) {
        current_tree[node_idx] = (Node){0, 0};
    } else {
        int mid = start + (end - start) / 2;
        build_tree(2 * node_idx, start, mid);
        build_tree(2 * node_idx + 1, mid + 1, end);
        current_tree[node_idx] = merge_nodes(current_tree[2 * node_idx], current_tree[2 * node_idx + 1]);
    }
}

void update_tree(int node_idx, int start, int end, int idx, Node val) {
    if (start == end) {
        current_tree[node_idx] = merge_nodes(current_tree[node_idx], val); // Take max
    } else {
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update_tree(2 * node_idx, start, mid, idx, val);
        } else {
            update_tree(2 * node_idx + 1, mid + 1, end, idx, val);
        }
        current_tree[node_idx] = merge_nodes(current_tree[2 * node_idx], current_tree[2 * node_idx + 1]);
    }
}

Node query_tree(int node_idx, int start, int end, int l, int r) {
    if (r < start || end < l || l > r) {
        return (Node){0, 0}; // Identity for max
    }
    if (l <= start && end <= r) {
        return current_tree[node_idx];
    }
    int mid = start + (end - start) / 2;
    Node p1 = query_tree(2 * node_idx, start, mid, l, r);
    Node p2 = query_tree(2 * node_idx + 1, mid + 1, end, l, r);
    return merge_nodes(p1, p2);
}

long long countNonDecreasingSubarrays(int* nums, int numsSize, int k) {
    // Step 1: Coordinate compression
    int* temp_nums = (int*)malloc(numsSize * sizeof(int));
    memcpy(temp_nums, nums, numsSize * sizeof(int));
    qsort(temp_nums, numsSize, sizeof(int), compare_ints);

    unique_nums_global = (int*)malloc(numsSize * sizeof(int));
    unique_nums_size_global = 0;
    if (numsSize > 0) {
        unique_nums_global[unique_nums_size_global++] = temp_nums[0];
        for (int i = 1; i < numsSize; ++i) {
            if (temp_nums[i] != temp_nums[i-1]) {
                unique_nums_global[unique_nums_size_global++] = temp_nums[i];
            }
        }
    }
    free(temp_nums);

    if (numsSize == 0) {
        free(unique_nums_global);
        return 0;
    }

    // dp_trees[j] is a segment tree representing states using j operations.
    // Each segment tree stores (max_len, total_count) for elements ending at current index.
    Node** dp_trees = (Node**)malloc((k + 1) * sizeof(Node*));
    current_tree_size = 4 * unique_nums_size_global;
    for (int j = 0; j <= k; ++j) {
        dp_trees[j] = (Node*)malloc(current_tree_size * sizeof(Node));
        current_tree = dp_trees[j]; // Set global tree pointer for build_tree
        build_tree(1, 0, unique_nums_size_global - 1);
    }

    long long max_total_subarrays = 0;

    for (int i = 0; i < numsSize; ++i) {
        int cur_val_orig_idx = get_compressed_idx(nums[i]);

        // Create a copy of the dp_trees states from (i-1) to use for calculations for current 'i'.
        // This is necessary because dp_trees[j] states are updated for current 'i'
        // but calculations for current 'i' might need dp_trees[j] or dp_trees[j-1] from (i-1).
        Node** prev_dp_trees = (Node**)malloc((k + 1) * sizeof(Node*));
        for(int j = 0; j <= k; ++j) {
            prev_dp_trees[j] = (Node*)malloc(current_tree_size * sizeof(Node));
            memcpy(prev_dp_trees[j], dp_trees[j], current_tree_size * sizeof(Node));
        }

        for (int j = k; j >= 0; --j) {
            // Case 1: nums[i] is NOT changed (cost 0)
            // Query from prev_dp_trees[j] (which holds states from i-1)
            current_tree = prev_dp_trees[j]; // Set global pointer to query from previous state
            Node prev_state_no_change = query_tree(1, 0, unique_nums_size_global - 1, 0, cur_val_orig_idx);

            long long cur_segment_len_no_change = prev_state_no_change.max_len + 1;
            long long cur_total_count_no_change = prev_state_no_change.total_count + cur_segment_len_no_change;

            // Update dp_trees[j] (for current i)
            current_tree = dp_trees[j]; // Set global pointer to update current state
            update_tree(1, 0, unique_nums_size_global - 1, cur_val_orig_idx, (Node){cur_segment_len_no_change, cur_total_count_no_change});

            // Case 2: nums[i] IS changed (cost 1)
            if (j > 0) {
                // Query from prev_dp_trees[j-1] (which holds states from i-1 with one less operation)
                current_tree = prev_dp_trees[j-1]; // Set global pointer to query from previous state
                Node prev_state_changed = query_tree(1, 0, unique_nums_size_global - 1, 0, unique_nums_size_global - 1); // Any previous value

                long long cur_segment_len_changed = prev_state_changed.max_len + 1;
                long long cur_total_count_changed = prev_state_changed.total_count + cur_segment_len_changed;

                // Update dp_trees[j] (for current i)
                current_tree = dp_trees[j]; // Set global pointer to update current state
                // When nums[i] is changed, we can set its value to anything.
                // To maximize future non-decreasing segments, we can conceptually set it to the largest possible value.
                // Thus, we update the state at the largest compressed index.
                update_tree(1, 0, unique_nums_size_global - 1, unique_nums_size_global - 1, (Node){cur_segment_len_changed, cur_total_count_changed});
            }
        }
        // Free prev_dp_trees for this iteration
        for(int j = 0; j <= k; ++j) {
            free(prev_dp_trees[j]);
        }
        free(prev_dp_trees);
    }

    // Find the maximum total_count across all dp_trees[j] (for any number of operations up to k)
    // and all possible ending values (any index in the segment tree).
    for (int j = 0; j <= k; ++j) {
        current_tree = dp_trees[j];
        Node res = query_tree(1, 0, unique_nums_size_global - 1, 0, unique_nums_size_global - 1);
        if (res.total_count > max_total_subarrays) {
            max_total_subarrays = res.total_count;
        }
    }

    // Free all allocated memory
    free(unique_nums_global);
    for (int j = 0; j <= k; ++j) {
        free(dp_trees[j]);
    }
    free(dp_trees);

    return max_total_subarrays;
}