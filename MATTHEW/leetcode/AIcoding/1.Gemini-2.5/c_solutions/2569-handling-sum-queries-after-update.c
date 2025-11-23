#include <stdlib.h>
#include <stdbool.h>

#define MAX_N 100000

long long tree_sum_active[4 * MAX_N];      // Stores sum of nums2[i] where nums1[i] is 1 in the segment
long long tree_total_sum_range[4 * MAX_N]; // Stores total sum of nums2[i] in the segment (constant)
bool tree_lazy[4 * MAX_N];                 // Lazy propagation flag for flips

int N_GLOBAL_SIZE;

void build(int node, int start, int end, int* nums1, int* nums2) {
    tree_lazy[node] = false; // Initialize lazy flag to false
    if (start == end) {
        // Leaf node: sum_active is nums2[start] if nums1[start] is 1, else 0
        tree_sum_active[node] = (long long)nums1[start] * nums2[start];
        // total_sum_range is simply nums2[start]
        tree_total_sum_range[node] = nums2[start];
    } else {
        int mid = (start + end) / 2;
        // Recursively build left and right children
        build(2 * node, start, mid, nums1, nums2);
        build(2 * node + 1, mid + 1, end, nums1, nums2);
        // Aggregate sums from children
        tree_sum_active[node] = tree_sum_active[2 * node] + tree_sum_active[2 * node + 1];
        tree_total_sum_range[node] = tree_total_sum_range[2 * node] + tree_total_sum_range[2 * node + 1];
    }
}

void push_down(int node) {
    if (tree_lazy[node]) {
        // Apply flip to left child
        tree_sum_active[2 * node] = tree_total_sum_range[2 * node] - tree_sum_active[2 * node];
        tree_lazy[2 * node] = !tree_lazy[2 * node];

        // Apply flip to right child
        tree_sum_active[2 * node + 1] = tree_total_sum_range[2 * node + 1] - tree_sum_active[2 * node + 1];
        tree_lazy[2 * node + 1] = !tree_lazy[2 * node + 1];

        // Reset current node's lazy flag
        tree_lazy[node] = false;
    }
}

void update_range(int node, int start, int end, int l, int r) {
    // If current segment is completely outside the update range
    if (start > end || start > r || end < l) {
        return;
    }

    // If current segment is completely inside the update range
    if (l <= start && end <= r) {
        // Flip sum_active: new sum_active = total_sum_range - old sum_active
        tree_sum_active[node] = tree_total_sum_range[node] - tree_sum_active[node];
        // Toggle lazy flag
        tree_lazy[node] = !tree_lazy[node];
        return;
    }

    // Push down lazy updates before recursing
    push_down(node);

    // Recurse for children
    int mid = (start + end) / 2;
    update_range(2 * node, start, mid, l, r);
    update_range(2 * node + 1, mid + 1, end, l, r);

    // After children are updated, update current node's sum_active
    tree_sum_active[node] = tree_sum_active[2 * node] + tree_sum_active[2 * node + 1];
}

long long* handleSumQueries(int* nums1, int nums1Size, int* nums2, int nums2Size, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    N_GLOBAL_SIZE = nums1Size;

    // Build the segment tree from nums1 and nums2
    build(1, 0, N_GLOBAL_SIZE - 1, nums1, nums2);

    // Count the number of type 2 queries to determine the size of the result array
    int type2_queries_count = 0;
    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 2) {
            type2_queries_count++;
        }
    }

    // Allocate memory for the results array
    long long* results = (long long*)malloc(type2_queries_count * sizeof(long long));
    *returnSize = 0; // Initialize returnSize for the results array

    // Process each query
    for (int i = 0; i < queriesSize; i++) {
        int type = queries[i][0];
        if (type == 1) {
            // Type 1 query: flip bits in range [l, r]
            int l = queries[i][1];
            int r = queries[i][2];
            update_range(1, 0, N_GLOBAL_SIZE - 1, l, r);
        } else { // type == 2
            // Type 2 query: calculate p + sum(nums2[i] for nums1[i] == 1)
            long long p_val = queries[i][1]; // The initial value 'p' from the query
            // The total sum of nums2[i] where nums1[i] is 1 is stored in the root of the segment tree
            results[*returnSize] = p_val + tree_sum_active[1];
            (*returnSize)++; // Increment the count of results stored
        }
    }

    return results;
}