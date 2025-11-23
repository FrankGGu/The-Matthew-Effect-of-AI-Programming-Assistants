#include <stdbool.h> // For bool type

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int left_size_of_x;
int right_size_of_x;

int dfs_calculate_sizes(struct TreeNode* node, int target_x_val) {
    if (node == NULL) {
        return 0;
    }

    // Recursively calculate the size of the left and right subtrees
    int current_left_subtree_size = dfs_calculate_sizes(node->left, target_x_val);
    int current_right_subtree_size = dfs_calculate_sizes(node->right, target_x_val);

    // If the current node is the target node 'x', record its children's subtree sizes
    if (node->val == target_x_val) {
        left_size_of_x = current_left_subtree_size;
        right_size_of_x = current_right_subtree_size;
    }

    // The size of the subtree rooted at 'node' is 1 (for node itself) + left subtree size + right subtree size
    return 1 + current_left_subtree_size + current_right_subtree_size;
}

bool btreeGameWinningStrategy(struct TreeNode* root, int n, int x) {
    // Reset global variables for each test case to avoid state leakage
    left_size_of_x = 0;
    right_size_of_x = 0;

    // First, traverse the tree to find the node 'x' and calculate the sizes of its left and right subtrees.
    // The return value of this call (total tree size) is 'n', which is already given.
    dfs_calculate_sizes(root, x);

    // Now we have the sizes of the left and right subtrees of 'x'.
    // The third possible region for Player 2 to pick is the "parent part" (all nodes not in 'x's subtree).
    // This includes 'x's parent, its ancestors, and any siblings of 'x' or 'x's ancestors.
    // Its size is: total nodes - (1 for node x itself) - left subtree size - right subtree size.
    int parent_part_size = n - 1 - left_size_of_x - right_size_of_x;

    // Player 2 will choose the region (left subtree of x, right subtree of x, or parent part)
    // that has the maximum number of nodes.
    // If Player 2 picks a region of size 'S', then Player 1 gets 'n - S' nodes.
    // Player 1 wins if (n - S) >= S, which simplifies to n >= 2 * S.
    // Conversely, Player 1 loses if Player 2 can find a region 'S' such that (n - S) < S,
    // which simplifies to n < 2 * S, or 2 * S > n.

    // Check if Player 2 can win by picking the left subtree of 'x'
    if (2 * left_size_of_x > n) {
        return false; // Player 2 wins
    }

    // Check if Player 2 can win by picking the right subtree of 'x'
    if (2 * right_size_of_x > n) {
        return false; // Player 2 wins
    }

    // Check if Player 2 can win by picking the "parent part"
    if (2 * parent_part_size > n) {
        return false; // Player 2 wins
    }

    // If none of the above conditions are met, it means Player 2 cannot find any region
    // that allows them to get strictly more than half the total nodes.
    // In this case, Player 1 wins (either by getting more nodes or tying, which Player 1 wins).
    return true;
}