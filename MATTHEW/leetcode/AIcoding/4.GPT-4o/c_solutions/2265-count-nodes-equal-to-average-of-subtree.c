int countNodesEqualToAverage(struct TreeNode* root, int* count) {
    if (!root) return 0;
    int leftSum = countNodesEqualToAverage(root->left, count);
    int leftCount = countNodesEqualToAverage(root->left, count);
    int rightSum = countNodesEqualToAverage(root->right, count);
    int rightCount = countNodesEqualToAverage(root->right, count);

    int totalSum = leftSum + rightSum + root->val;
    int totalCount = leftCount + rightCount + 1;

    if (totalCount > 0 && totalSum / totalCount == root->val) {
        (*count)++;
    }

    return totalSum;
}

int averageOfSubtree(struct TreeNode* root) {
    int count = 0;
    countNodesEqualToAverage(root, &count);
    return count;
}