#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define INF (INT_MAX / 2)

typedef struct {
    int L, R, original_idx;
} Query;

int compareQueries(const void* a, const void* b) {
    return ((Query*)a)->R - ((Query*)b)->R;
}

int compareInts(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* seg_tree;
int N_seg_tree;

void build_seg_tree(int node, int start, int end) {
    if (start == end) {
        seg_tree[node] = INF;
    } else {
        int mid = (start + end) / 2;
        build_seg_tree(2 * node, start, mid);
        build_seg_tree(2 * node + 1, mid + 1, end);
        seg_tree[node] = INF;
    }
}

void update_seg_tree(int node, int start, int end, int idx, int val) {
    if (start == end) {
        seg_tree[node] = val;
    } else {
        int mid = (start + end) / 2;
        if (start <= idx && idx <= mid) {
            update_seg_tree(2 * node, start, mid, idx, val);
        } else {
            update_seg_tree(2 * node + 1, mid + 1, end, idx, val);
        }
        seg_tree[node] = (seg_tree[2 * node] < seg_tree[2 * node + 1]) ? seg_tree[2 * node] : seg_tree[2 * node + 1];
    }
}

int query_seg_tree(int node, int start, int end, int l, int r) {
    if (r < start || end < l || l > r) {
        return INF;
    }
    if (l <= start && end <= r) {
        return seg_tree[node];
    }
    int mid = (start + end) / 2;
    int p1 = query_seg_tree(2 * node, start, mid, l, r);
    int p2 = query_seg_tree(2 * node + 1, mid + 1, end, l, r);
    return (p1 < p2) ? p1 : p2;
}

int* minAbsoluteDifferenceQueries(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int N = numsSize;
    int Q = queriesSize;

    *returnSize = Q;
    int* ans = (int*)malloc(Q * sizeof(int));
    if (!ans) return NULL;

    int* temp_nums = (int*)malloc(N * sizeof(int));
    if (!temp_nums) { free(ans); return NULL; }
    memcpy(temp_nums, nums, N * sizeof(int));

    qsort(temp_nums, N, sizeof(int), compareInts);

    int* unique_vals = (int*)malloc(N * sizeof(int));
    if (!unique_vals) { free(ans); free(temp_nums); return NULL; }
    int unique_count = 0;
    if (N > 0) {
        unique_vals[unique_count++] = temp_nums[0];
        for (int i = 1; i < N; ++i) {
            if (temp_nums[i] != temp_nums[i-1]) {
                unique_vals[unique_count++] = temp_nums[i];
            }
        }
    }

    int* compressed_nums = (int*)malloc(N * sizeof(int));
    if (!compressed_nums) { free(ans); free(temp_nums); free(unique_vals); return NULL; }
    for (int i = 0; i < N; ++i) {
        void* item = bsearch(&nums[i], unique_vals, unique_count, sizeof(int), compareInts);
        compressed_nums[i] = ((int*)item - unique_vals);
    }

    free(temp_nums);
    free(unique_vals);

    Query* query_structs = (Query*)malloc(Q * sizeof(Query));
    if (!query_structs) { free(ans); free(compressed_nums); return NULL; }
    for (int i = 0; i < Q; ++i) {
        query_structs[i].L = queries[i][0];
        query_structs[i].R = queries[i][1];
        query_structs[i].original_idx = i;
    }

    qsort(query_structs, Q, sizeof(Query), compareQueries);

    int* prev_pos = (int*)malloc(N * sizeof(int));
    if (!prev_pos) { free(ans); free(compressed_nums); free(query_structs); return NULL; }
    int* last_seen_compressed = (int*)malloc(unique_count * sizeof(int));
    if (!last_seen_compressed) { free(ans); free(compressed_nums); free(query_structs); free(prev_pos); return NULL; }
    memset(last_seen_compressed, -1, unique_count * sizeof(int));

    for (int i = 0; i < N; ++i) {
        int val_compressed = compressed_nums[i];
        prev_pos[i] = last_seen_compressed[val_compressed];
        last_seen_compressed[val_compressed] = i;
    }

    memset(last_seen_compressed, -1, unique_count * sizeof(int));

    N_seg_tree = N;
    seg_tree = (int*)malloc(4 * N_seg_tree * sizeof(int));
    if (!seg_tree) { free(ans); free(compressed_nums); free(query_structs); free(prev_pos); free(last_seen_compressed); return NULL; }
    build_seg_tree(1, 0, N_seg_tree - 1);

    int query_pointer = 0;
    for (int i = 0; i < N; ++i) {
        int val_compressed = compressed_nums[i];

        if (last_seen_compressed[val_compressed] != -1) {
            int prev_idx = last_seen_compressed[val_compressed];
            update_seg_tree(1, 0, N_seg_tree - 1, prev_idx, i - prev_idx);

            if (prev_pos[prev_idx] != -1) {
                update_seg_tree(1, 0, N_seg_tree - 1, prev_pos[prev_idx], INF);
            }
        }
        last_seen_compressed[val_compressed] = i;

        while (query_pointer < Q && query_structs[query_pointer].R == i) {
            Query current_query = query_structs[query_pointer];
            int result = query_seg_tree(1, 0, N_seg_tree - 1, current_query.L, current_query.R);
            ans[current_query.original_idx] = (result == INF) ? -1 : result;
            query_pointer++;
        }
    }

    free(compressed_nums);
    free(query_structs);
    free(prev_pos);
    free(last_seen_compressed);
    free(seg_tree);

    return ans;
}