struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool findRootToLeafPath(struct TreeNode* node, int currentSum, int targetSum) {
    if (!node) return false;
    currentSum += node->val;
    if (!node->left && !node->right) return currentSum == targetSum;
    return findRootToLeafPath(node->left, currentSum, targetSum) ||
           findRootToLeafPath(node->right, currentSum, targetSum);
}

bool hasPathSum(struct TreeNode* root, int targetSum) {
    return findRootToLeafPath(root, 0, targetSum);
}