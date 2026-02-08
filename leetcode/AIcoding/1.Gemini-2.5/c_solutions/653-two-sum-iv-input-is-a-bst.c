#define VALUE_OFFSET 10000
#define SEEN_ARRAY_SIZE (2 * VALUE_OFFSET + 1)

bool findTargetDFS(struct TreeNode* root, int k, bool* seen_values) {
    if (root == NULL) {
        return false;
    }

    // Calculate the complement needed for the current node's value
    int complement = k - root->val;

    // Map the complement to an array index
    int complement_idx = complement + VALUE_OFFSET;

    // Check if the complement has been seen before and is within valid index range
    if (complement_idx >= 0 && complement_idx < SEEN_ARRAY_SIZE && seen_values[complement_idx]) {
        return true; // Found a pair
    }

    // Mark the current node's value as seen
    // The current node's value is guaranteed to be within [-10000, 10000],
    // so its index will always be within [0, 20000].
    int current_val_idx = root->val + VALUE_OFFSET;
    seen_values[current_val_idx] = true;

    // Recursively search in left and right subtrees
    // Use short-circuiting OR (||) to return true as soon as a pair is found
    return findTargetDFS(root->left, k, seen_values) || findTargetDFS(root->right, k, seen_values);
}

bool findTarget(struct TreeNode* root, int k) {
    // Declare and initialize a boolean array to act as a hash set.
    // This array will be re-initialized for each test case, which is important
    // for LeetCode's test environment where multiple test cases might run
    // in the same process.
    bool seen_values[SEEN_ARRAY_SIZE];
    for (int i = 0; i < SEEN_ARRAY_SIZE; ++i) {
        seen_values[i] = false;
    }

    // Start the DFS traversal
    return findTargetDFS(root, k, seen_values);
}