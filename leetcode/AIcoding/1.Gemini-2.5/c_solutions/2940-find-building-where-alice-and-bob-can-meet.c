#include <stdlib.h> // For malloc, free, realloc
#include <string.h> // For memset (though calloc initializes to zero)

static int* seg_tree_heights;
static int N_seg_tree; // Max index for segment tree, which is heightsSize

static inline int max(int a, int b) {
    return a > b ? a : b;
}

static void update_seg_tree(int node_idx, int current_low, int current_high, int target_idx, int value) {
    if (current_low == current_high) { // Leaf node
        seg_tree_heights[node_idx] = value;
        return;
    }

    int mid = current_low + (current_high - current_low) / 2;
    if (target_idx <= mid) {
        update_seg_tree(2 * node_idx, current_low, mid, target_idx, value);
    } else {
        update_seg_tree(2 * node_idx + 1, mid + 1, current_high, target_idx, value);
    }
    seg_tree_heights[node_idx] = max(seg_tree_heights[2 * node_idx], seg_tree_heights[2 * node_idx + 1]);
}

static int query_seg_tree(int node_idx, int current_low, int current_high, int query_low, int query_high, int threshold) {
    // If current node's range is outside query range, or max in current range is not greater than threshold
    if (current_high < query_low || current_low > query_high || seg_tree_heights[node_idx] <= threshold) {
        return -1;
    }

    // If leaf node, and its value is greater than threshold, return its index
    if (current_low == current_high) {
        return current_low;
    }

    int mid = current_low + (current_high - current_low) / 2;

    // First try left child
    // Ensure the query range for the left child is within its bounds
    int res = query_seg_tree(2 * node_idx, current_low, mid, query_low, query_high, threshold);
    if (res != -1) {
        return res;
    }

    // If not found in left child, try right child
    // Ensure the query range for the right child is within its bounds
    return query_seg_tree(2 * node_idx + 1, mid + 1, current_high, query_low, query_high, threshold);
}

typedef struct {
    int original_idx;
    int aliceBuilding;
    int bobBuilding;
    int start_idx; // max(aliceBuilding, bobBuilding)
    int target_height_alice; // heights[aliceBuilding]
    int target_height_bob;   // heights[bobBuilding]
} Query;

int* findBuildings(int* heights, int heightsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Allocate memory for results
    *returnSize = queriesSize;
    int* ans = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; ++i) {
        ans[i] = -1; // Initialize all answers to -1
    }

    // Prepare queries for offline processing
    // Use dynamic arrays to simulate vector<vector<Query>>
    Query** queries_by_start_idx = (Query**)malloc(heightsSize * sizeof(Query*));
    int* queries_by_start_idx_counts = (int*)calloc(heightsSize, sizeof(int));
    int* queries_by_start_idx_capacities = (int*)calloc(heightsSize, sizeof(int));

    for (int i = 0; i < heightsSize; ++i) {
        queries_by_start_idx_capacities[i] = 4; // Initial capacity
        queries_by_start_idx[i] = (Query*)malloc(queries_by_start_idx_capacities[i] * sizeof(Query));
    }

    for (int i = 0; i < queriesSize; ++i) {
        int alice = queries[i][0];
        int bob = queries[i][1];
        int start = max(alice, bob);

        if (queries_by_start_idx_counts[start] == queries_by_start_idx_capacities[start]) {
            queries_by_start_idx_capacities[start] *= 2;
            queries_by_start_idx[start] = (Query*)realloc(queries_by_start_idx[start], queries_by_start_idx_capacities[start] * sizeof(Query));
        }
        queries_by_start_idx[start][queries_by_start_idx_counts[start]].original_idx = i;
        queries_by_start_idx[start][queries_by_start_idx_counts[start]].aliceBuilding = alice;
        queries_by_start_idx[start][queries_by_start_idx_counts[start]].bobBuilding = bob;
        queries_by_start_idx[start][queries_by_start_idx_counts[start]].start_idx = start;
        queries_by_start_idx[start][queries_by_start_idx_counts[start]].target_height_alice = heights[alice];
        queries_by_start_idx[start][queries_by_start_idx_counts[start]].target_height_bob = heights[bob];
        queries_by_start_idx_counts[start]++;
    }

    // Initialize segment tree
    N_seg_tree = heightsSize;
    seg_tree_heights = (int*)calloc(4 * N_seg_tree, sizeof(int)); // Initialize all to 0

    // Offline processing from right to left
    for (int i = heightsSize - 1; i >= 0; --i) {
        // Make heights[i] available in the segment tree
        update_seg_tree(1, 0, N_seg_tree - 1, i, heights[i]);

        // Process queries that have their effective starting point (max(alice, bob)) at index i
        for (int j = 0; j < queries_by_start_idx_counts[i]; ++j) {
            Query q = queries_by_start_idx[i][j];
            int h_target = max(q.target_height_alice, q.target_height_bob);

            // Query segment tree for the smallest index k in range [i, N_seg_tree - 1]
            // such that heights[k] is strictly greater than h_target.
            int res = query_seg_tree(1, 0, N_seg_tree - 1, i, N_seg_tree - 1, h_target);
            ans[q.original_idx] = res;
        }
    }

    // Free allocated memory
    for (int i = 0; i < heightsSize; ++i) {
        free(queries_by_start_idx[i]);
    }
    free(queries_by_start_idx);
    free(queries_by_start_idx_counts);
    free(queries_by_start_idx_capacities);
    free(seg_tree_heights);

    return ans;
}