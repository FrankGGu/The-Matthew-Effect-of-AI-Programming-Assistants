#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For memset

#define MAX_N 100005
#define MAX_COORD_SIZE (2 * MAX_N)

int seg_tree[4 * MAX_COORD_SIZE];

int max(int a, int b) {
    return a > b ? a : b;
}

void update_seg_tree(int node, int start, int end, int idx, int val) {
    if (start == end) {
        seg_tree[node] = max(seg_tree[node], val);
        return;
    }
    int mid = start + (end - start) / 2;
    if (start <= idx && idx <= mid) {
        update_seg_tree(2 * node, start, mid, idx, val);
    } else {
        update_seg_tree(2 * node + 1, mid + 1, end, idx, val);
    }
    seg_tree[node] = max(seg_tree[2 * node], seg_tree[2 * node + 1]);
}

int query_seg_tree(int node, int start, int end, int l, int r) {
    if (r < start || end < l || l > r) { 
        return 0;
    }
    if (l <= start && end <= r) { 
        return seg_tree[node];
    }
    int mid = start + (end - start) / 2;
    int p1 = query_seg_tree(2 * node, start, mid, l, r);
    int p2 = query_seg_tree(2 * node + 1, mid + 1, end, l, r);
    return max(p1, p2);
}

int compare_ints(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int get_compressed_index(int val, int* coords, int coords_size) {
    int low = 0, high = coords_size - 1;
    int ans_idx = coords_size;
    while(low <= high) {
        int mid = low + (high - low) / 2;
        if (coords[mid] >= val) {
            ans_idx = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans_idx;
}

int longestSubsequence(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }

    int* all_coords = (int*)malloc(sizeof(int) * 2 * numsSize);
    int coord_count = 0;

    for (int i = 0; i < numsSize; ++i) {
        all_coords[coord_count++] = nums[i];
        all_coords[coord_count++] = nums[i] - k;
    }

    qsort(all_coords, coord_count, sizeof(int), compare_ints);

    int unique_coord_count = 0;
    if (coord_count > 0) {
        all_coords[unique_coord_count++] = all_coords[0];
        for (int i = 1; i < coord_count; ++i) {
            if (all_coords[i] != all_coords[i-1]) {
                all_coords[unique_coord_count++] = all_coords[i];
            }
        }
    }

    memset(seg_tree, 0, sizeof(seg_tree));

    int max_overall_len = 0;

    for (int i = 0; i < numsSize; ++i) {
        int current_val = nums[i];

        int query_lower_val = max(1, current_val - k);
        int query_upper_val = current_val - 1;

        int query_l_idx = get_compressed_index(query_lower_val, all_coords, unique_coord_count);
        int query_r_idx = get_compressed_index(query_upper_val + 1, all_coords, unique_coord_count) - 1;

        int prev_max_len = 0;
        if (query_l_idx <= query_r_idx) {
            prev_max_len = query_seg_tree(1, 0, unique_coord_count - 1, query_l_idx, query_r_idx);
        }

        int current_lis_len = 1 + prev_max_len;

        int current_val_idx = get_compressed_index(current_val, all_coords, unique_coord_count);

        update_seg_tree(1, 0, unique_coord_count - 1, current_val_idx, current_lis_len);

        max_overall_len = max(max_overall_len, current_lis_len);
    }

    free(all_coords);
    return max_overall_len;
}