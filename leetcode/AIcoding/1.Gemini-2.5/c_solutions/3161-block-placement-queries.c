#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset if needed, or just for NULL

long long max(long long a, long long b) {
    return a > b ? a : b;
}

typedef struct SegTreeNode {
    int start_idx; // compressed start index
    int end_idx;   // compressed end index
    long long total_len; // actual length of the segment [unique_coords_arr[start_idx], unique_coords_arr[end_idx+1])
    long long max_left_free;
    long long max_right_free;
    long long max_total_free; // Maximum free space anywhere within the node's range
    bool is_occupied; // lazy tag: true if this entire segment is occupied
    struct SegTreeNode *left_child;
    struct SegTreeNode *right_child;
} SegTreeNode;

#define MAX_UNIQUE_COORDS_VAL (400002)
#define MAX_SEG_NODES (2 * MAX_UNIQUE_COORDS_VAL) // Max nodes in segment tree (approx 2*N for N leaves)
SegTreeNode tree_nodes[MAX_SEG_NODES];
int node_count;

int* unique_coords_arr;
int unique_coords_size;

SegTreeNode DUMMY_NODE = {0, 0, 0, 0, 0, 0, false, NULL, NULL};

SegTreeNode* new_seg_node() {
    SegTreeNode* node = &tree_nodes[node_count++];
    node->left_child = NULL;
    node->right_child = NULL;
    node->is_occupied = false;
    return node;
}

int compare_ints(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int get_coord_idx(int val) {
    int low = 0, high = unique_coords_size - 1, ans = unique_coords_size;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (unique_coords_arr[mid] >= val) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

void push_down(SegTreeNode* node) {
    if (node == NULL || !node->is_occupied) {
        return;
    }
    if (node->left_child != NULL) {
        node->left_child->is_occupied = true;
        node->left_child->max_left_free = 0;
        node->left_child->max_right_free = 0;
        node->left_child->max_total_free = 0;
    }
    if (node->right_child != NULL) {
        node->right_child->is_occupied = true;
        node->right_child->max_left_free = 0;
        node->right_child->max_right_free = 0;
        node->right_child->max_total_free = 0;
    }
    node->is_occupied = false; // Reset lazy tag
}

void merge(SegTreeNode* parent, SegTreeNode* left_child, SegTreeNode* right_child) {
    parent->total_len = left_child->total_len + right_child->total_len;

    parent->max_left_free = left_child->max_left_free;
    if (left_child->max_left_free == left_child->total_len) {
        parent->max_left_free += right_child->max_left_free;
    }

    parent->max_right_free = right_child->max_right_free;
    if (right_child->max_right_free == right_child->total_len) {
        parent->max_right_free += left_child->max_right_free;
    }

    parent->max_total_free = max(left_child->max_total_free, right_child->max_total_free);
    parent->max_total_free = max(parent->max_total_free, left_child->max_right_free + right_child->max_left_free);
}

SegTreeNode* build(int start_idx, int end_idx) {
    SegTreeNode* node = new_seg_node();
    node->start_idx = start_idx;
    node->end_idx = end_idx;

    if (start_idx == end_idx) { // Leaf node representing interval [unique_coords_arr[start_idx], unique_coords_arr[start_idx+1])
        node->total_len = (long long)unique_coords_arr[start_idx + 1] - unique_coords_arr[start_idx];
        node->max_left_free = node->total_len;
        node->max_right_free = node->total_len;
        node->max_total_free = node->total_len;
    } else {
        int mid_idx = start_idx + (end_idx - start_idx) / 2;
        node->left_child = build(start_idx, mid_idx);
        node->right_child = build(mid_idx + 1, end_idx);
        merge(node, node->left_child, node->right_child);
    }
    return node;
}

void update(SegTreeNode* node, int query_start_idx, int query_end_idx) {
    if (node == NULL || query_start_idx > node->end_idx || query_end_idx < node->start_idx) {
        return; // Current node's range is outside query range
    }

    if (query_start_idx <= node->start_idx && query_end_idx >= node->end_idx) {
        // Current node's range is completely inside query range
        node->is_occupied = true;
        node->max_left_free = 0;
        node->max_right_free = 0;
        node->max_total_free = 0;
        return;
    }

    push_down(node); // Push down lazy tag before recursing

    update(node->left_child, query_start_idx, query_end_idx);
    update(node->right_child, query_start_idx, query_end_idx);

    merge(node, node->left_child, node->right_child); // Re-merge after children updates
}

SegTreeNode merge_query_results(SegTreeNode left_res, SegTreeNode right_res) {
    SegTreeNode res;
    res.total_len = left_res.total_len + right_res.total_len;

    res.max_left_free = left_res.max_left_free;
    if (left_res.max_left_free == left_res.total_len) {
        res.max_left_free += right_res.max_left_free;
    }

    res.max_right_free = right_res.max_right_free;
    if (right_res.max_right_free == right_res.total_len) {
        res.max_right_free += left_res.max_right_free;
    }

    res.max_total_free = max(left_res.max_total_free, right_res.max_total_free);
    res.max_total_free = max(res.max_total_free, left_res.max_right_free + right_res.max_left_free);

    // These fields are not relevant for merged query results
    res.is_occupied = false;
    res.left_child = NULL;
    res.right_child = NULL;
    res.start_idx = 0; // Dummy values
    res.end_idx = 0;   // Dummy values
    return res;
}

SegTreeNode query(SegTreeNode* node, int query_start_idx, int query_end_idx) {
    if (node == NULL || query_start_idx > node->end_idx || query_end_idx < node->start_idx) {
        return DUMMY_NODE; // Current node's range is outside query range
    }

    if (node->is_occupied) {
        return DUMMY_NODE; // Fully occupied, so no free space
    }

    if (query_start_idx <= node->start_idx && query_end_idx >= node->end_idx) {
        return *node; // Node's range is completely within query range, return its values
    }

    push_down(node); // Ensure children are up-to-date

    SegTreeNode left_res = query(node->left_child, query_start_idx, query_end_idx);
    SegTreeNode right_res = query(node->right_child, query_start_idx, query_end_idx);

    return merge_query_results(left_res, right_res);
}

bool* blockPlacementQueries(int** blocks, int blocksSize, int* blocksColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // 1. Collect all relevant coordinates
    int* temp_coords = (int*)malloc(MAX_UNIQUE_COORDS_VAL * sizeof(int));
    int temp_coords_count = 0;

    temp_coords[temp_coords_count++] = 0; // Always include 0 as a possible start coordinate

    for (int i = 0; i < blocksSize; ++i) {
        temp_coords[temp_coords_count++] = blocks[i][0];
        temp_coords[temp_coords_count++] = blocks[i][0] + blocks[i][1];
    }

    for (int i = 0; i < queriesSize; ++i) {
        temp_coords[temp_coords_count++] = queries[i][1];
        temp_coords[temp_coords_count++] = queries[i][1] + queries[i][2];
    }

    // Add a sentinel coordinate far beyond any possible block end to cover all queries.
    // Max possible coordinate for pos + len is 10^9 (pos) + 10^9 (len) = 2 * 10^9.
    // So, a value slightly larger than 2 * 10^9 is appropriate.
    temp_coords[temp_coords_count++] = 2000000000 + 7; 

    // 2. Sort and remove duplicates
    qsort(temp_coords, temp_coords_count, sizeof(int), compare_ints);

    unique_coords_arr = (int*)malloc(temp_coords_count * sizeof(int));
    unique_coords_size = 0;
    if (temp_coords_count > 0) {
        unique_coords_arr[unique_coords_size++] = temp_coords[0];
        for (int i = 1; i < temp_coords_count; ++i) {
            if (temp_coords[i] != temp_coords[i-1]) {
                unique_coords_arr[unique_coords_size++] = temp_coords[i];
            }
        }
    }
    free(temp_coords); // Free temporary array

    // Initialize segment tree
    SegTreeNode* root = NULL;
    node_count = 0; // Reset node counter for global array

    // A segment tree requires at least two unique coordinates to form an interval [coord_i, coord_{i+1})
    if (unique_coords_size >= 2) {
        root = build(0, unique_coords_size - 2); // Build on indices 0 to (unique_coords_size - 2)
    }

    // 3. Place initial blocks
    if (root != NULL) {
        for (int i = 0; i < blocksSize; ++i) {
            int pos = blocks[i][0];
            int len = blocks[i][1];
            int start_idx = get_coord_idx(pos);
            int end_idx = get_coord_idx(pos + len) - 1;
            if (start_idx <= end_idx) {
                update(root, start_idx, end_idx);
            }
        }
    }

    // 4. Process queries
    bool* results = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; ++i) {
        int type = queries[i][0];
        int pos = queries[i][1];
        int len = queries[i][2];

        if (type == 0) { // Add block
            if (root != NULL) {
                int start_idx = get_coord_idx(pos);
                int end_idx = get_coord_idx(pos + len) - 1;
                if (start_idx <= end_idx) {
                    update(root, start_idx, end_idx);
                }
            }
        } else { // Check for space
            if (root == NULL || unique_coords_size < 2) { // No intervals to place blocks
                results[i] = false;
                continue;
            }
            int start_idx = get_coord_idx(pos);
            // Query up to the last possible interval in the segment tree
            SegTreeNode query_result = query(root, start_idx, unique_coords_size - 2);
            results[i] = (query_result.max_total_free >= len);
        }
    }

    free(unique_coords_arr); // Free dynamically allocated unique_coords_arr
    return results;
}