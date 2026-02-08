#include <stdlib.h> // For malloc, free
#include <string.h> // For memset (optional, but good practice for init)

#include "uthash.h"

typedef struct {
    int city_id;
    int last_day;
    UT_hash_handle hh;
} CityRainInfo;

typedef struct {
    int count; // Number of available dry days in this segment tree node's range
} SegmentTreeNode;

SegmentTreeNode* seg_tree;
int seg_tree_N; // Max index for segment tree (rainsSize - 1)

void seg_tree_build(int node, int start, int end) {
    seg_tree[node].count = 0;
    if (start == end) {
        return;
    }
    int mid = (start + end) / 2;
    seg_tree_build(2 * node, start, mid);
    seg_tree_build(2 * node + 1, mid + 1, end);
}

void seg_tree_update(int node, int start, int end, int idx, int val) {
    if (start == end) {
        seg_tree[node].count = val;
        return;
    }
    int mid = (start + end) / 2;
    if (idx <= mid) { // Go left
        seg_tree_update(2 * node, start, mid, idx, val);
    } else { // Go right
        seg_tree_update(2 * node + 1, mid + 1, end, idx, val);
    }
    // Update parent node's count based on children
    seg_tree[node].count = seg_tree[2 * node].count + seg_tree[2 * node + 1].count;
}

int seg_tree_find_first_one(int node, int start, int end, int query_l, int query_r) {
    // If no 1s in this node's range, or current node range is outside query range
    if (seg_tree[node].count == 0 || start > query_r || end < query_l) {
        return -1;
    }

    // If leaf node and it has a 1, return its index
    if (start == end) {
        return start;
    }

    int mid = (start + end) / 2;
    int res = -1;

    // Search left child if its range overlaps with query_l
    if (query_l <= mid) {
        res = seg_tree_find_first_one(2 * node, start, mid, query_l, query_r);
    }
    if (res != -1) {
        return res; // Found in left child
    }

    // Search right child if not found in left and its range overlaps with query_r
    if (query_r > mid) {
        res = seg_tree_find_first_one(2 * node + 1, mid + 1, end, query_l, query_r);
    }
    return res;
}

int* avoidFlood(int* rains, int rainsSize, int* returnSize) {
    *returnSize = rainsSize;
    int* ans = (int*)malloc(sizeof(int) * rainsSize);
    if (!ans) return NULL;

    CityRainInfo* last_rain_map = NULL; // Head of the hash table

    // Initialize segment tree
    // seg_tree_N represents the maximum index in the rains array (rainsSize - 1)
    seg_tree_N = rainsSize - 1; 
    // A segment tree typically needs 4*N space in the worst case
    int seg_tree_allocated_size = 4 * rainsSize; 
    seg_tree = (SegmentTreeNode*)malloc(sizeof(SegmentTreeNode) * seg_tree_allocated_size);
    if (!seg_tree) {
        free(ans);
        return NULL;
    }
    // Build the segment tree from node 1, covering the range [0, seg_tree_N]
    // Only build if rainsSize > 0, otherwise seg_tree_N could be -1
    if (rainsSize > 0) {
        seg_tree_build(1, 0, seg_tree_N);
    }

    for (int i = 0; i < rainsSize; ++i) {
        int city_id = rains[i];

        if (city_id > 0) { // It rains in city_id
            ans[i] = city_id;

            CityRainInfo* s;
            HASH_FIND_INT(last_rain_map, &city_id, s);

            if (s != NULL) { // City_id rained before, check for flood
                int prev_rain_day = s->last_day;

                // Find the earliest dry day 'j' such that prev_rain_day < j < i
                // Query range for dry days: [prev_rain_day + 1, i - 1]
                int dry_day_idx = -1;
                int query_start = prev_rain_day + 1;
                int query_end = i - 1;

                if (query_start <= query_end) { // Only search if the range is valid
                    dry_day_idx = seg_tree_find_first_one(1, 0, seg_tree_N, query_start, query_end);
                }

                if (dry_day_idx == -1) { // No available dry day, flood occurs
                    *returnSize = 1;
                    ans[0] = -1;
                    // Clean up hash table and segment tree before returning
                    CityRainInfo *current_city, *tmp_city;
                    HASH_ITER(hh, last_rain_map, current_city, tmp_city) {
                        HASH_DEL(last_rain_map, current_city);
                        free(current_city);
                    }
                    free(seg_tree);
                    return ans;
                } else {
                    // Use dry_day_idx to dry city_id
                    ans[dry_day_idx] = city_id;
                    // Mark this dry day as used in the segment tree
                    seg_tree_update(1, 0, seg_tree_N, dry_day_idx, 0); 
                }
            }

            // Update last_rain_day for city_id
            if (s == NULL) {
                s = (CityRainInfo*)malloc(sizeof(CityRainInfo));
                if (!s) { // Handle malloc failure
                    // Clean up existing allocations before returning
                    CityRainInfo *current_city, *tmp_city;
                    HASH_ITER(hh, last_rain_map, current_city, tmp_city) {
                        HASH_DEL(last_rain_map, current_city);
                        free(current_city);
                    }
                    free(seg_tree);
                    free(ans);
                    return NULL;
                }
                s->city_id = city_id;
                HASH_ADD_INT(last_rain_map, city_id, s);
            }
            s->last_day = i;

        } else { // rains[i] == 0, it's a dry day
            ans[i] = 1; // Default value, will be updated if used to dry a specific city
            // Mark this day as an available dry day in the segment tree
            if (rainsSize > 0) { // Ensure index is valid for segment tree
                seg_tree_update(1, 0, seg_tree_N, i, 1); 
            }
        }
    }

    // Clean up hash table and segment tree
    CityRainInfo *current_city, *tmp_city;
    HASH_ITER(hh, last_rain_map, current_city, tmp_city) {
        HASH_DEL(last_rain_map, current_city);
        free(current_city);
    }
    free(seg_tree);

    return ans;
}