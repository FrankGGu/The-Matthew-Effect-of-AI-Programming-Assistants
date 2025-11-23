int getDepth(struct TreeNode* node) {
    if (node == NULL) {
        return -1;
    }
    int depth = 0;
    while (node->left != NULL) {
        node = node->left;
        depth++;
    }
    return depth;
}

int countNodes(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }

    int leftDepth = getDepth(root->left);
    int rightDepth = getDepth(root->right);

    if (leftDepth == rightDepth) {
        return (1 << (leftDepth + 1)) + countNodes(root->right);
    } else {
        return (1 << (rightDepth + 1)) + countNodes(root->left);
    }
}