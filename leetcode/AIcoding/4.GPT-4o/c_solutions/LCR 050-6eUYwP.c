int pathSum(struct TreeNode* root, int sum) {
    if (!root) return 0;
    return pathSumFrom(root, sum) + pathSum(root->left, sum) + pathSum(root->right, sum);
}

int pathSumFrom(struct TreeNode* node, int sum) {
    if (!node) return 0;
    int count = 0;
    if (node->val == sum) count++;
    count += pathSumFrom(node->left, sum - node->val);
    count += pathSumFrom(node->right, sum - node->val);
    return count;
}