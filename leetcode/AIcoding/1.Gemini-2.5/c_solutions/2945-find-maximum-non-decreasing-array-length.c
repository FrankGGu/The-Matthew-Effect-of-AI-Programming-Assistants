#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For memcpy

static int* unique_values_arr_global;
static int unique_values_count_global;

static int compareInts(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

static int get_compressed_idx(int val) {
    int low = 0, high = unique_values_count_global - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (unique_values_arr_global[mid] == val) {
            return mid;
        } else if (unique_values_arr_global[mid] < val) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -1; // Should not happen if value is guaranteed to be in the array
}

typedef struct {
    int max_val;
} SegTreeNode;

static SegTreeNode* tree_global;
static int tree_size_global; // Max index in compressed values + 1

static void build_segment_tree(int node, int start, int end) {
    if (start == end) {
        tree_global[node].max_val = 0;
    } else {
        int mid = start + (end - start) / 2;
        build_segment_tree(2 * node, start, mid);
        build_segment_tree(2 * node + 1, mid + 1, end);
        tree_global[node].max_val = 0; // Parent node initially 0
    }
}

static void update_segment_tree(int node, int start, int end, int idx, int val) {
    if (start == end) {
        if (val > tree_global[node].max_val) {
            tree_global[node].max_val = val;
        }
    } else {
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update_segment_tree(2 * node, start, mid, idx, val);
        } else {
            update_segment_tree(2 * node + 1, mid + 1, end, idx, val);
        }
        tree_global[node].max_val = (tree_global[2 * node].max_val > tree_global[2 * node + 1].max_val) ? tree_global[2 * node].max_val : tree_global[2 * node + 1].max_val;
    }
}

static int query_segment_tree(int node, int start, int end, int l, int r) {
    if (r < start || end < l || l > r) { // No overlap or invalid range
        return 0;
    }
    if (l <= start && end <= r) { // Current segment fully within query range
        return tree_global[node].max_val;
    }
    int mid = start + (end - start) / 2;
    int p1 = query_segment_tree(2 * node, start, mid, l, r);
    int p2 = query_segment_tree(2 * node + 1, mid + 1, end, l, r);
    return (p1 > p2) ? p1 : p2;
}

typedef struct {
    int u; // nums[i]
    int v; // target[i]
} Item;

static int compareItems(const void* a, const void* b) {
    Item* itemA = (Item*)a;
    Item* itemB = (Item*)b;
    if (itemA->u != itemB->u) {
        return itemA->u - itemB->u;
    }
    return itemA->v - itemB->v;
}

int findMaximumLength(int* nums, int numsSize, int* target, int targetSize) {
    if (numsSize == 0) {
        return 0;
    }

    // 1. Filter items: keep only pairs where nums[i] <= target[i]
    Item* filtered_items = (Item*)malloc(numsSize * sizeof(Item));
    int filtered_count = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] <= target[i]) {
            filtered_items[filtered_count].u = nums[i];
            filtered_items[filtered_count].v = target[i];
            filtered_count++;
        }
    }

    // If no valid pairs, the maximum length is 1 (by picking any single nums[i])
    if (filtered_count == 0) {
        free(filtered_items);
        return 1;
    }

    // 2. Sort filtered items based on u (nums[i]), then v (target[i])
    qsort(filtered_items, filtered_count, sizeof(Item), compareItems);

    // 3. Collect all unique values from filtered items for coordinate compression
    int* all_values_raw = (int*)malloc(2 * filtered_count * sizeof(int));
    int all_values_count = 0;
    for (int i = 0; i < filtered_count; ++i) {
        all_values_raw[all_values_count++] = filtered_items[i].u;
        all_values_raw[all_values_count++] = filtered_items[i].v;
    }

    // Sort all values and remove duplicates
    qsort(all_values_raw, all_values_count, sizeof(int), compareInts);

    if (all_values_count > 0) {
        int current_unique = all_values_raw[0];
        int write_idx = 1;
        for (int i = 1; i < all_values_count; ++i) {
            if (all_values_raw[i] != current_unique) {
                all_values_raw[write_idx++] = all_values_raw[i];
                current_unique = all_values_raw[i];
            }
        }
        unique_values_count_global = write_idx;
    } else {
        unique_values_count_global = 0;
    }

    unique_values_arr_global = (int*)malloc(unique_values_count_global * sizeof(int));
    memcpy(unique_values_arr_global, all_values_raw, unique_values_count_global * sizeof(int));
    free(all_values_raw); // Free temporary array

    // 4. Initialize segment tree
    tree_size_global = unique_values_count_global;
    tree_global = (SegTreeNode*)malloc(4 * tree_size_global * sizeof(SegTreeNode));
    build_segment_tree(1, 0, tree_size_global - 1);

    // 5. Dynamic Programming with Segment Tree
    int max_overall_len = 1; // Minimum length is 1 (picking any single nums[i])

    for (int i = 0; i < filtered_count; ++i) {
        int u_val = filtered_items[i].u;
        int v_val = filtered_items[i].v;

        int idx_u = get_compressed_idx(u_val);
        int idx_v = get_compressed_idx(v_val);

        // Query for the maximum length of a sequence ending with a value <= u_val
        // This represents `... target[j]` where `target[j] <= nums[i]`
        int prev_max_len = query_segment_tree(1, 0, tree_size_global - 1, 0, idx_u);

        // The current pair (u_val, v_val) extends the previous sequence by 2 elements
        int current_len_for_this_pair = prev_max_len + 2;

        // Update the overall maximum length found so far
        if (current_len_for_this_pair > max_overall_len) {
            max_overall_len = current_len_for_this_pair;
        }

        // Update the segment tree with the new maximum length ending with v_val
        update_segment_tree(1, 0, tree_size_global - 1, idx_v, current_len_for_this_pair);
    }

    // Cleanup allocated memory
    free(filtered_items);
    free(unique_values_arr_global);
    free(tree_global);

    return max_overall_len;
}