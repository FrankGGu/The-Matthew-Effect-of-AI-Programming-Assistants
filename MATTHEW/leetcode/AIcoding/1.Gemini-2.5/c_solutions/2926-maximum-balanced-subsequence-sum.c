#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h> // For LLONG_MIN

#ifndef LLONG_MIN
#define LLONG_MIN (-9223372036854775807LL - 1)
#endif

int compareLongLong(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

long long *seg_tree;
int seg_tree_range_size; // Number of unique values, which is the effective range for segment tree indices

void build_seg_tree(int node, int start, int end) {
    if (start == end) {
        seg_tree[node] = 0;
    } else {
        int mid = start + (end - start) / 2;
        build_seg_tree(2 * node, start, mid);
        build_seg_tree(2 * node + 1, mid + 1, end);
        seg_tree[node] = 0; // Internal nodes also initialized to 0
    }
}

void update_seg_tree(int node, int start, int end, int idx, long long val) {
    if (start == end) {
        seg_tree[node] = (seg_tree[node] > val) ? seg_tree[node] : val;
    } else {
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update_seg_tree(2 * node, start, mid, idx, val);
        } else {
            update_seg_tree(2 * node + 1, mid + 1, end, idx, val);
        }
        seg_tree[node] = (seg_tree[2 * node] > seg_tree[2 * node + 1]) ? seg_tree[2 * node] : seg_tree[2 * node + 1];
    }
}

long long query_seg_tree(int node, int start, int end, int l, int r) {
    if (r < start || end < l) {
        return LLONG_MIN;
    }
    if (l <= start && end <= r) {
        return seg_tree[node];
    }
    int mid = start + (end - start) / 2;
    long long p1 = query_seg_tree(2 * node, start, mid, l, r);
    long long p2 = query_seg_tree(2 * node + 1, mid + 1, end, l, r);
    return (p1 > p2) ? p1 : p2;
}

int get_compressed_idx(long long target_val, long long *unique_vals, int unique_count) {
    int low = 0, high = unique_count - 1;
    int ans_idx = -1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (unique_vals[mid] >= target_val) {
            ans_idx = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans_idx;
}

long long maxBalancedSubsequenceSum(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    long long *transformed_vals = (long long *)malloc(numsSize * sizeof(long long));
    if (!transformed_vals) return 0;

    for (int i = 0; i < numsSize; ++i) {
        transformed_vals[i] = (long long)nums[i] - i;
    }

    long long *unique_vals = (long long *)malloc(numsSize * sizeof(long long));
    if (!unique_vals) {
        free(transformed_vals);
        return 0;
    }
    memcpy(unique_vals, transformed_vals, numsSize * sizeof(long long));

    qsort(unique_vals, numsSize, sizeof(long long), compareLongLong);

    int unique_count = 0;
    if (numsSize > 0) {
        unique_vals[unique_count++] = unique_vals[0];
        for (int i = 1; i < numsSize; ++i) {
            if (unique_vals[i] != unique_vals[i-1]) {
                unique_vals[unique_count++] = unique_vals[i];
            }
        }
    }

    seg_tree_range_size = unique_count;
    seg_tree = (long long *)malloc(4 * seg_tree_range_size * sizeof(long long));
    if (!seg_tree) {
        free(transformed_vals);
        free(unique_vals);
        return 0;
    }
    build_seg_tree(1, 0, seg_tree_range_size - 1);

    long long max_overall_sum = 0;

    for (int i = 0; i < numsSize; ++i) {
        long long current_val_transformed = (long long)nums[i] - i;
        int compressed_idx = get_compressed_idx(current_val_transformed, unique_vals, unique_count);

        long long max_prev_dp = query_seg_tree(1, 0, seg_tree_range_size - 1, 0, compressed_idx);

        long long current_dp = (long long)nums[i] + ((max_prev_dp > 0) ? max_prev_dp : 0LL);

        if (current_dp > max_overall_sum) {
            max_overall_sum = current_dp;
        }

        update_seg_tree(1, 0, seg_tree_range_size - 1, compressed_idx, current_dp);
    }

    free(transformed_vals);
    free(unique_vals);
    free(seg_tree);

    return max_overall_sum;
}