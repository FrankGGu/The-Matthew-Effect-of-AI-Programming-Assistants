int pathSumHelper(struct TreeNode* root, int sum, int currentSum) {
    if (!root) return 0;
    currentSum += root->val;
    int count = (currentSum == sum) ? 1 : 0;
    count += pathSumHelper(root->left, sum, currentSum);
    count += pathSumHelper(root->right, sum, currentSum);
    return count;
}

void pathSumFromNode(struct TreeNode* root, int sum, int* count) {
    if (!root) return;
    *count += pathSumHelper(root, sum, 0);
    pathSumFromNode(root->left, sum, count);
    pathSumFromNode(root->right, sum, count);
}

int pathSum(struct TreeNode* root, int sum) {
    int count = 0;
    pathSumFromNode(root, sum, &count);
    return count;
}