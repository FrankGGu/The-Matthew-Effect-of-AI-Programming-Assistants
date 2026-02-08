#include <stdlib.h>
#include <string.h>
#include <limits.h> // For INT_MAX

typedef struct {
    int* data;
    int size;
    int capacity;
} IntVector;

void init_vector(IntVector* vec, int initial_capacity) {
    vec->data = (int*)malloc(sizeof(int) * initial_capacity);
    vec->size = 0;
    vec->capacity = initial_capacity;
}

void push_back(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        vec->capacity *= 2;
        vec->data = (int*)realloc(vec->data, sizeof(int) * vec->capacity);
    }
    vec->data[vec->size++] = val;
}

void free_vector(IntVector* vec) {
    free(vec->data);
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

int compare_ints(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int unique_sorted_array(int* arr, int size) {
    if (size == 0) return 0;
    int j = 0;
    for (int i = 1; i < size; i++) {
        if (arr[i] != arr[j]) {
            arr[++j] = arr[i];
        }
    }
    return j + 1;
}

int custom_lower_bound(const int* arr, int size, int val) {
    int low = 0, high = size - 1;
    int ans = size; // Default to size if val is greater than all elements
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= val) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

typedef struct {
    int x, y, z;
    int y_comp, z_comp; // Compressed coordinates
    int original_idx;
} Point;

typedef struct {
    int a, b, c;
    int b_comp, c_comp; // Compressed coordinates
    int original_idx;
} Query;

int compare_points(const void* p1, const void* p2) {
    return ((Point*)p2)->x - ((Point*)p1)->x;
}

int compare_queries(const void* q1, const void* q2) {
    return ((Query*)q2)->a - ((Query*)q1)->a;
}

typedef struct ZSegTreeNode {
    int min_val;
    int left_child_idx;
    int right_child_idx;
} ZSegTreeNode;

#define MAX_Z_TREE_NODES (3600000) 
ZSegTreeNode z_seg_tree_nodes[MAX_Z_TREE_NODES];
int next_z_node_idx; // 0 is reserved for NULL/empty node

#define MAX_Y_TREE_ROOTS (1600000) 
int y_seg_tree_roots[MAX_Y_TREE_ROOTS]; // Stores indices into z_seg_tree_nodes

int z_seg_tree_size; // Number of distinct compressed Z coordinates
int y_seg_tree_size; // Number of distinct compressed Y coordinates

int get_min_val(int node_idx) {
    if (node_idx == 0) {
        return INT_MAX;
    }
    return z_seg_tree_nodes[node_idx].min_val;
}

int create_new_z_node() {
    if (next_z_node_idx >= MAX_Z_TREE_NODES) {
        // This indicates an error or insufficient MAX_Z_TREE_NODES
        // In a real competitive programming scenario, this might lead to runtime error.
        // For LeetCode, we assume the limits are sufficient.
        exit(1); 
    }
    int new_idx = next_z_node_idx++;
    z_seg_tree_nodes[new_idx].min_val = INT_MAX;
    z_seg_tree_nodes[new_idx].left_child_idx = 0;
    z_seg_tree_nodes[new_idx].right_child_idx = 0;
    return new_idx;
}

int update_z_seg_tree(int node_idx, int range_start, int range_end, int z_comp, int val) {
    if (node_idx == 0) { // If current node is null, create a new one
        node_idx = create_new_z_node();
    }

    if (range_start == range_end) { // Leaf node
        if (val < z_seg_tree_nodes[node_idx].min_val) {
            z_seg_tree_nodes[node_idx].min_val = val;
        }
        return node_idx;
    }

    int mid = range_start + (range_end - range_start) / 2;
    if (z_comp <= mid) {
        z_seg_tree_nodes[node_idx].left_child_idx = update_z_seg_tree(z_seg_tree_nodes[node_idx].left_child_idx, range_start, mid, z_comp, val);
    } else {
        z_seg_tree_nodes[node_idx].right_child_idx = update_z_seg_tree(z_seg_tree_nodes[node_idx].right_child_idx, mid + 1, range_end, z_comp, val);
    }

    // Update min_val for current node from its children
    int left_min = get_min_val(z_seg_tree_nodes[node_idx].left_child_idx);
    int right_min = get_min_val(z_seg_tree_nodes[node_idx].right_child_idx);
    z_seg_tree_nodes[node_idx].min_val = (left_min < right_min) ? left_min : right_min;

    return node_idx;
}

int query_z_seg_tree(int node_idx, int range_start, int range_end, int query_z_start, int query_z_end) {
    // If node is null or its range is outside the query range
    if (node_idx == 0 || query_z_start > range_end || query_z_end < range_start) {
        return INT_MAX;
    }

    // If current node's range is fully within the query range
    if (query_z_start <= range_start && range_end <= query_z_end) {
        return z_seg_tree_nodes[node_idx].min_val;
    }

    int mid = range_start + (range_end - range_start) / 2;
    int res_left = query_z_seg_tree(z_seg_tree_nodes[node_idx].left_child_idx, range_start, mid, query_z_start, query_z_end);
    int res_right = query_z_seg_tree(z_seg_tree_nodes[node_idx].right_child_idx, mid + 1, range_end, query_z_start, query_z_end);

    return (res_left < res_right) ? res_left : res_right;
}

void update_y_seg_tree(int node_idx, int range_start, int range_end, int y_comp, int z_comp, int val) {
    // Update the Z-Segment Tree associated with the current Y-Segment Tree node
    y_seg_tree_roots[node_idx] = update_z_seg_tree(y_seg_tree_roots[node_idx], 0, z_seg_tree_size - 1, z_comp, val);

    if (range_start == range_end) { // Leaf node in Y-tree
        return;
    }

    int mid = range_start + (range_end - range_start) / 2;
    if (y_comp <= mid) {
        update_y_seg_tree(2 * node_idx, range_start, mid, y_comp, z_comp, val);
    } else {
        update_y_seg_tree(2 * node_idx + 1, mid + 1, range_end, y_comp, z_comp, val);
    }
}

int query_y_seg_tree(int node_idx, int range_start, int range_end, int query_y_start, int query_y_end, int query_z_start, int query_z_end) {
    // If node is null or its range is outside the query Y-range
    if (node_idx == 0 || query_y_start > range_end || query_y_end < range_start) {
        return INT_MAX;
    }

    // If current Y-node's range is fully within the query Y-range
    if (query_y_start <= range_start && range_end <= query_y_end) {
        // Query its associated Z-Segment Tree for the Z-range
        return query_z_seg_tree(y_seg_tree_roots[node_idx], 0, z_seg_tree_size - 1, query_z_start, query_z_end);
    }

    int mid = range_start + (range_end - range_start) / 2;
    int res_left = query_y_seg_tree(2 * node_idx, range_start, mid, query_y_start, query_y_end, query_z_start, query_z_end);
    int res_right = query_y_seg_tree(2 * node_idx + 1, mid + 1, range_end, query_y_start, query_y_end, query_z_start, query_z_end);

    return (res_left < res_right) ? res_left : res_right;
}

int* triggerTime(int** points, int pointsSize, int* pointsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    (void)pointsColSize; // Unused parameter
    (void)queriesColSize; // Unused parameter

    // --- 1. Collect all Y and Z coordinates for compression ---
    IntVector all_y_coords, all_z_coords;
    // Initial capacity can be pointsSize + queriesSize, as each point/query contributes at most one Y and one Z.
    init_vector(&all_y_coords, pointsSize + queriesSize);
    init_vector(&all_z_coords, pointsSize + queriesSize);

    for (int i = 0; i < pointsSize; i++) {
        push_back(&all_y_coords, points[i][1]); // Y-coordinate
        push_back(&all_z_coords, points[i][2]); // Z-coordinate
    }
    for (int i = 0; i < queriesSize; i++) {
        push_back(&all_y_coords, queries[i][1]); // B-coordinate (for Y-axis)
        push_back(&all_z_coords, queries[i][2]); // C-coordinate (for Z-axis)
    }

    // Sort and unique Y coordinates to get compressed mapping
    qsort(all_y_coords.data, all_y_coords.size, sizeof(int), compare_ints);
    y_seg_tree_size = unique_sorted_array(all_y_coords.data, all_y_coords.size);

    // Sort and unique Z coordinates to get compressed mapping
    qsort(all_z_coords.data, all_z_coords.size, sizeof(int), compare_ints);
    z_seg_tree_size = unique_sorted_array(all_z_coords.data, all_z_coords.size);

    // --- 2. Prepare Point and Query structs with compressed coordinates ---
    Point* p_arr = (Point*)malloc(sizeof(Point) * pointsSize);
    for (int i = 0; i < pointsSize; i++) {
        p_arr[i].x = points[i][0];
        p_arr[i].y = points[i][1];
        p_arr[i].z = points[i][2];
        p_arr[i].y_comp = custom_lower_bound(all_y_coords.data, y_seg_tree_size, points[i][1]);
        p_arr[i].z_comp = custom_lower_bound(all_z_coords.data, z_seg_tree_size, points[i][2]);
        p_arr[i].original_idx = i; // Store original index (time)
    }

    Query* q_arr = (Query*)malloc(sizeof(Query) * queriesSize);
    for (int i = 0; i < queriesSize; i++) {
        q_arr[i].a = queries[i][0];
        q_arr[i].b = queries[i][1];
        q_arr[i].c = queries[i][2];
        q_arr[i].b_comp = custom_lower_bound(all_y_coords.data, y_seg_tree_size, queries[i][1]);
        q_arr[i].c_comp = custom_lower_bound(all_z_coords.data, z_seg_tree_size, queries[i][2]);
        q_arr[i].original_idx = i; // Store original query index
    }

    // --- 3. Sort points and queries ---
    // Sort points by x-coordinate in descending order
    qsort(p_arr, pointsSize, sizeof(Point), compare_points);
    // Sort queries by a-coordinate in descending order
    qsort(q_arr, queriesSize, sizeof(Query), compare_queries);

    // --- 4. Initialize Segment Tree ---
    next_z_node_idx = 1; // 0 is reserved for null/empty nodes in z_seg_tree_nodes
    // y_seg_tree_roots is a global array, so it's implicitly initialized to 0,
    // which correctly represents that each Y-node initially has an empty Z-tree.

    // --- 5. Process queries using sweep-line and 2D Segment Tree ---
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    int point_ptr = 0; // Pointer to iterate through sorted points
    for (int i = 0; i < queriesSize; i++) {
        Query current_query = q_arr[i];

        // Add all points whose x-coordinate is >= current query's 'a' to the data structure
        while (point_ptr < pointsSize && p_arr[point_ptr].x >= current_query.a) {
            update_y_seg_tree(1, 0, y_seg_tree_size - 1, 
                              p_arr[point_ptr].y_comp, p_arr[point_ptr].z_comp, 
                              p_arr[point_ptr].original_idx);
            point_ptr++;
        }

        // Query for the minimum original_idx (earliest time)
        // We need points where y_j >= b_i and z_j >= c_i.
        // In compressed coordinates, this means y_comp >= b_comp and z_comp >= c_comp.
        int result = query_y_seg_tree(1, 0, y_seg_tree_size - 1,
                                       current_query.b_comp, y_seg_tree_size - 1, // Query Y from b_comp to max_y_comp
                                       current_query.c_comp, z_seg_tree_size - 1); // Query Z from c_comp to max_z_comp

        ans[current_query.original_idx] = (result == INT_MAX) ? -1 : result;
    }

    // --- 6. Cleanup ---
    free_vector(&all_y_coords);
    free_vector(&all_z_coords);
    free(p_arr);
    free(q_arr);

    return ans;
}