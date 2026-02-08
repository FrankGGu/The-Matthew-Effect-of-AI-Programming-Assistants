/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int sumRootToLeaf(struct TreeNode* root){
    return dfs(root, 0);
}

int dfs(struct TreeNode* node, int currentSum) {
    if (node == NULL) {
        return 0;
    }

    currentSum = (currentSum << 1) | node->val;

    if (node->left == NULL && node->right == NULL) {
        return currentSum;
    }

    return dfs(node->left, currentSum) + dfs(node->right, currentSum);
}