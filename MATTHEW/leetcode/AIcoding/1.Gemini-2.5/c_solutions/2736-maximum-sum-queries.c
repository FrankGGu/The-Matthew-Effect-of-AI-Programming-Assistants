#include <stdlib.h> // For malloc, qsort, free
#include <string.h> // For memset

#define MAX_N 100005

typedef struct {
    int val1;
    int val2;
} Point;

typedef struct {
    int x;
    int y;
    int original_idx;
} Query;

int cmp_points(const void* a, const void* b) {
    // Sort points by val1 (nums1[i]) in descending order
    return ((Point*)b)->val1 - ((Point*)a)->val1;
}

int cmp_queries(const void* a, const void* b) {
    // Sort queries by x in descending order
    return ((Query*)b)->x - ((Query*)a)->x;
}

int cmp_int(const void* a, const void* b) {
    // Sort integers in ascending order
    return *(int*)a - *(int*)b;
}

int segment_tree[4 * MAX_N];
int num_distinct_nums2_global;

void build_segment_tree(int node, int start, int end) {
    if (start == end) {
        segment_tree[node] = -1;
    } else {
        int mid = start + (end - start) / 2;
        build_segment_tree(2 * node, start, mid);
        build_segment_tree(2 * node + 1, mid + 1, end);
        segment_tree[node] = -1; // Parent also initialized to -1
    }
}

void update_segment_tree(int node, int start, int end, int idx, int val) {
    if (start == end) {
        if (val > segment_tree[node]) {
            segment_tree[node] = val;
        }
    } else {
        int mid = start + (end - start) / 2;
        if (idx <= mid) { // Go to left child
            update_segment_tree(2 * node, start, mid, idx, val);
        } else { // Go to right child
            update_segment_tree(2 * node + 1, mid + 1, end, idx, val);
        }
        // Update parent node with the maximum of its children's values
        segment_tree[node] = (segment_tree[2 * node] > segment_tree[2 * node + 1]) ? segment_tree[2 * node] : segment_tree[2 * node + 1];
    }
}

int query_segment_tree(int node, int start, int end, int l, int r) {
    // If the current segment tree range is completely outside the query range
    if (r < start || end < l) {
        return -1;
    }
    // If the current segment tree range is completely inside the query range
    if (l <= start && end <= r) {
        return segment_tree[node];
    }
    // If there is a partial overlap, query both children and take the maximum of their results
    int mid = start + (end - start) / 2;
    int p1 = query_segment_tree(2 * node, start, mid, l, r);
    int p2 = query_segment_tree(2 * node + 1, mid + 1, end, l, r);
    return (p1 > p2) ? p1 : p2;
}

int get_lower_bound_idx(int* arr, int n, int key) {
    int low = 0, high = n - 1, ans = n;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= key) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int* maximumSumQueries(int* nums1, int nums1Size, int* nums2, int nums2Size, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = nums1Size;
    int m = queriesSize;

    // Allocate memory for points and query data structures
    Point* points = (Point*)malloc(n * sizeof(Point));
    for (int i = 0; i < n; ++i) {
        points[i].val1 = nums1[i];
        points[i].val2 = nums2[i];
    }

    Query* query_data = (Query*)malloc(m * sizeof(Query));
    for (int i = 0; i < m; ++i) {
        query_data[i].x = queries[i][0];
        query_data[i].y = queries[i][1];
        query_data[i].original_idx = i; // Store original index to place results correctly
    }

    // Coordinate compression for nums2 values
    // Collect all nums2 values, sort them, and remove duplicates.
    // This creates a mapping from actual nums2 values to compressed indices for the segment tree.
    int* distinct_nums2 = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        distinct_nums2[i] = nums2[i];
    }
    qsort(distinct_nums2, n, sizeof(int), cmp_int);

    // Remove duplicates
    num_distinct_nums2_global = 0;
    if (n > 0) {
        distinct_nums2[num_distinct_nums2_global++] = distinct_nums2[0];
        for (int i = 1; i < n; ++i) {
            if (distinct_nums2[i] != distinct_nums2[num_distinct_nums2_global - 1]) {
                distinct_nums2[num_distinct_nums2_global++] = distinct_nums2[i];
            }
        }
    }

    // Sort points by nums1[i] in descending order
    qsort(points, n, sizeof(Point), cmp_points);
    // Sort queries by x in descending order
    qsort(query_data, m, sizeof(Query), cmp_queries);

    // Allocate memory for the result array and initialize it with -1
    int* ans = (int*)malloc(m * sizeof(int));
    *returnSize = m;
    memset(ans, -1, m * sizeof(int));

    // Initialize segment tree only if there are distinct nums2 values to operate on
    if (num_distinct_nums2_global > 0) {
        build_segment_tree(1, 0, num_distinct_nums2_global - 1);
    }

    int point_idx = 0; // Pointer for iterating through sorted points
    // Process queries in sorted order
    for (int i = 0; i < m; ++i) {
        Query current_query = query_data[i];

        // Add all points satisfying nums1[j] >= current_query.x to the segment tree.
        // Since both points and queries are sorted by their first component in descending order,
        // we only need to add points once as we sweep through queries.
        while (point_idx < n && points[point_idx].val1 >= current_query.x) {
            // Find the compressed index for points[point_idx].val2
            int compressed_idx = get_lower_bound_idx(distinct_nums2, num_distinct_nums2_global, points[point_idx].val2);

            // Update the segment tree with the sum points[j].val1 + points[j].val2
            // at its corresponding compressed index. This operation is valid only if
            // there are distinct nums2 values (i.e., num_distinct_nums2_global > 0).
            // The compressed_idx will always be valid within [0, num_distinct_nums2_global-1]
            // because distinct_nums2 contains all nums2 values.
            if (num_distinct_nums2_global > 0) {
                update_segment_tree(1, 0, num_distinct_nums2_global - 1, compressed_idx, points[point_idx].val1 + points[point_idx].val2);
            }
            point_idx++;
        }

        // Find the starting compressed index for querying nums2[j] >= current_query.y
        int query_y_compressed_idx = get_lower_bound_idx(distinct_nums2, num_distinct_nums2_global, current_query.y);

        // If there are valid nums2 values in the range [current_query.y, max_nums2_value]
        // (i.e., the lower bound index is within the valid range of compressed indices)
        if (query_y_compressed_idx < num_distinct_nums2_global) {
            // Query the segment tree for the maximum sum in the relevant range of compressed indices
            ans[current_query.original_idx] = query_segment_tree(1, 0, num_distinct_nums2_global - 1, query_y_compressed_idx, num_distinct_nums2_global - 1);
        } else {
            // No nums2[j] value is >= current_query.y among the available points.
            // The answer for this query remains -1, which was set during initialization.
        }
    }

    // Free dynamically allocated memory
    free(points);
    free(query_data);
    free(distinct_nums2);

    return ans;
}