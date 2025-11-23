#include <stdlib.h> // Required for malloc

#define MAX_COORD 1000000000

typedef struct SegTreeNode {
    struct SegTreeNode *left;  // Pointer to left child
    struct SegTreeNode *right; // Pointer to right child
    int count;                 // Number of colored points in the range represented by this node
    int lazy;                  // Lazy tag: 0=none, 1=set to colored, 2=set to uncolored
} SegTreeNode;

SegTreeNode* seg_root;

SegTreeNode* createNode() {
    SegTreeNode* node = (SegTreeNode*)malloc(sizeof(SegTreeNode));
    node->left = NULL;
    node->right = NULL;
    node->count = 0;
    node->lazy = 0; // Initialize with no lazy tag
    return node;
}

void pushdown(SegTreeNode* node, int L, int R) {
    if (!node || node->lazy == 0) {
        return;
    }

    // Create children if they don't exist
    if (!node->left) {
        node->left = createNode();
    }
    if (!node->right) {
        node->right = createNode();
    }

    int mid = L + (R - L) / 2;

    // Apply lazy tag to children
    node->left->lazy = node->lazy;
    node->right->lazy = node->lazy;

    // Update children's counts based on the lazy tag
    if (node->lazy == 1) { // Set to colored
        node->left->count = (mid - L + 1);
        node->right->count = (R - (mid + 1) + 1);
    } else { // Set to uncolored (node->lazy == 2)
        node->left->count = 0;
        node->right->count = 0;
    }

    node->lazy = 0; // Clear the current node's lazy tag after pushing it down
}

void pullup(SegTreeNode* node) {
    node->count = (node->left ? node->left->count : 0) +
                  (node->right ? node->right->count : 0);
}

void updateRange(SegTreeNode* node, int L, int R, int queryL, int queryR, int color_state) {
    // If the current node's range [L, R] is completely outside the query range [queryL, queryR]
    if (R < queryL || L > queryR) {
        return;
    }

    // If the current node's range [L, R] is completely inside the query range [queryL, queryR]
    if (queryL <= L && R <= queryR) {
        node->lazy = color_state;
        node->count = (color_state == 1) ? (R - L + 1) : 0;
        return;
    }

    // Otherwise, the current node's range partially overlaps or contains the query range.
    // Push down lazy tags before recursing.
    pushdown(node, L, R);

    int mid = L + (R - L) / 2;
    updateRange(node->left, L, mid, queryL, queryR, color_state);
    updateRange(node->right, mid + 1, R, queryL, queryR, color_state);

    // After children are updated, pull up their counts to update the current node's count.
    pullup(node);
}

void initColoringBST() {
    // In a typical LeetCode environment, a global variable might persist across test cases.
    // For a proper solution, if `initColoringBST` can be called multiple times,
    // memory from previous calls should be freed to prevent leaks.
    // For simplicity, assuming it's called once per test or memory is implicitly managed.
    // A recursive function to free nodes would be needed for full cleanup.
    seg_root = createNode(); // Create the root node for the entire range [1, MAX_COORD]
}

void color(int start, int end) {
    // Ensure start and end are within valid bounds (1 to MAX_COORD)
    if (start > end || start > MAX_COORD || end < 1) return;
    start = (start < 1) ? 1 : start;
    end = (end > MAX_COORD) ? MAX_COORD : end;

    updateRange(seg_root, 1, MAX_COORD, start, end, 1); // 1 for coloring
}

void uncolor(int start, int end) {
    if (start > end || start > MAX_COORD || end < 1) return;
    start = (start < 1) ? 1 : start;
    end = (end > MAX_COORD) ? MAX_COORD : end;

    updateRange(seg_root, 1, MAX_COORD, start, end, 2); // 2 for uncoloring
}

int getColoredCount() {
    if (!seg_root) return 0;
    return seg_root->count;
}