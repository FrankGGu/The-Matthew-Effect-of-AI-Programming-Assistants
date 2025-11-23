bool btreeGameWinningMove(struct TreeNode* root, int n, int x) {
    int leftCount = 0, rightCount = 0;

    void countNodes(struct TreeNode* node) {
        if (!node) return;
        leftCount += countNodes(node->left);
        rightCount += countNodes(node->right);
        return leftCount + rightCount + 1;
    }

    countNodes(root);

    int xCount = 0;
    struct TreeNode* xNode = findNode(root, x);
    if (xNode) {
        xCount = 1 + countNodes(xNode->left) + countNodes(xNode->right);
    }

    int totalCount = n;
    int otherCount = totalCount - xCount;

    return otherCount > totalCount / 2 || leftCount > totalCount / 2 || rightCount > totalCount / 2;
}

struct TreeNode* findNode(struct TreeNode* root, int x) {
    if (!root) return NULL;
    if (root->val == x) return root;
    struct TreeNode* left = findNode(root->left, x);
    if (left) return left;
    return findNode(root->right, x);
}