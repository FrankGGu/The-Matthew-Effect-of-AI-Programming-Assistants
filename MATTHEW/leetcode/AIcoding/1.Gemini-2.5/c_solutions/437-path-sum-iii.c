int countPathsFromNode(struct TreeNode* node, int currentTarget) {
    if (node == NULL) {
        return 0;
    }

    int count = 0;
    if (node->val == currentTarget) {
        count++;
    }

    count += countPathsFromNode(node->left, currentTarget - node->val);
    count += countPathsFromNode(node->right, currentTarget - node->val);

    return count;
}

int pathSum(struct TreeNode* root, int targetSum) {
    if (root == NULL) {
        return 0;
    }

    int totalPaths = countPathsFromNode(root, targetSum);

    totalPaths += pathSum(root->left, targetSum);

    totalPaths += pathSum(root->right, targetSum);

    return totalPaths;
}