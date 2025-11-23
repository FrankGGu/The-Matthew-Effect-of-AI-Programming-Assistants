struct TreeNode* addOneRow(struct TreeNode* root, int val, int depth) {
    if (depth == 1) {
        struct TreeNode* newRoot = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newRoot->val = val;
        newRoot->left = root;
        newRoot->right = NULL;
        return newRoot;
    }
    void addRow(struct TreeNode* node, int currentDepth) {
        if (!node) return;
        if (currentDepth == depth - 1) {
            struct TreeNode* newLeft = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            newLeft->val = val;
            newLeft->left = node->left;
            newLeft->right = NULL;
            node->left = newLeft;

            struct TreeNode* newRight = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            newRight->val = val;
            newRight->left = NULL;
            newRight->right = node->right;
            node->right = newRight;
        } else {
            addRow(node->left, currentDepth + 1);
            addRow(node->right, currentDepth + 1);
        }
    }
    addRow(root, 1);
    return root;
}