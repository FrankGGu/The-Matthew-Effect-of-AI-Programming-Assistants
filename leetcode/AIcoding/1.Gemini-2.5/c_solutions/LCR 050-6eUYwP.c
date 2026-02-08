int countPathsFromNode(struct TreeNode* node, long long targetSum) {
    if (node == NULL) {
        return 0;
    }

    int count = 0;
    if (node->val == targetSum) {
        count++;
    }

    count += countPathsFromNode(node->left, targetSum - node->val);
    count += countPathsFromNode(node->right, targetSum - node->val);

    return count;
}

int pathSum(struct TreeNode* root, int targetSum) {
    if (root == NULL) {
        return 0;
    }

    int total_paths = countPathsFromNode(root, targetSum);

    total_paths += pathSum(root->left, targetSum);
    total_paths += pathSum(root->right, targetSum);

    return total_paths;
}