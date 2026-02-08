int countGoodNodesRecursive(struct TreeNode* node, int maxSoFar) {
    if (node == NULL) {
        return 0;
    }

    int currentMax = maxSoFar > node->val ? maxSoFar : node->val;
    int goodNodesCount = 0;

    if (node->val >= maxSoFar) {
        goodNodesCount = 1;
    }

    goodNodesCount += countGoodNodesRecursive(node->left, currentMax);
    goodNodesCount += countGoodNodesRecursive(node->right, currentMax);

    return goodNodesCount;
}

int goodNodes(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }
    return countGoodNodesRecursive(root, root->val);
}