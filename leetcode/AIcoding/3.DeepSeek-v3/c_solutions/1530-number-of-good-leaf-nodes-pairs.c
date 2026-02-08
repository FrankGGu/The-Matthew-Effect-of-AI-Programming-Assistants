/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int countPairs(struct TreeNode* root, int distance) {
    int result = 0;

    void dfs(struct TreeNode* node, int* leaves) {
        if (!node) return;

        if (!node->left && !node->right) {
            leaves[0] = 1;
            for (int i = 1; i <= distance; i++) {
                leaves[i] = 0;
            }
            return;
        }

        int left_leaves[distance + 1];
        int right_leaves[distance + 1];
        for (int i = 0; i <= distance; i++) {
            left_leaves[i] = 0;
            right_leaves[i] = 0;
        }

        dfs(node->left, left_leaves);
        dfs(node->right, right_leaves);

        for (int i = 0; i <= distance; i++) {
            for (int j = 0; j <= distance; j++) {
                if (i + j + 2 <= distance) {
                    result += left_leaves[i] * right_leaves[j];
                }
            }
        }

        for (int i = 0; i < distance; i++) {
            leaves[i + 1] = left_leaves[i] + right_leaves[i];
        }
        leaves[0] = 0;
    }

    int leaves[distance + 1];
    dfs(root, leaves);

    return result;
}