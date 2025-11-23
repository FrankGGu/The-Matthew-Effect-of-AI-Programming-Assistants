int maxSum = 0;

int dfs(struct TreeNode* node, int* isBST) {
    if (!node) {
        *isBST = 1;
        return 0;
    }

    int leftIsBST, rightIsBST;
    int leftSum = dfs(node->left, &leftIsBST);
    int rightSum = dfs(node->right, &rightIsBST);

    if (leftIsBST && rightIsBST && (!node->left || node->val > node->left->val) && (!node->right || node->val < node->right->val)) {
        int currentSum = leftSum + rightSum + node->val;
        maxSum = maxSum > currentSum ? maxSum : currentSum;
        *isBST = 1;
        return currentSum;
    }

    *isBST = 0;
    return 0;
}

int maxSumBST(struct TreeNode* root) {
    maxSum = 0;
    int isBST;
    dfs(root, &isBST);
    return maxSum;
}