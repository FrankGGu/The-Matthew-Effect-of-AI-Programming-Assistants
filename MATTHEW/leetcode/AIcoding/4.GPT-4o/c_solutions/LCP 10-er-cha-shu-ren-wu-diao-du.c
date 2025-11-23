struct TreeNode* buildTree(int* inorder, int inorderSize, int* postorder, int postorderSize) {
    if (inorderSize == 0 || postorderSize == 0) {
        return NULL;
    }

    int rootVal = postorder[postorderSize - 1];
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = rootVal;

    int rootIndex = 0;
    while (inorder[rootIndex] != rootVal) {
        rootIndex++;
    }

    root->left = buildTree(inorder, rootIndex, postorder, rootIndex);
    root->right = buildTree(inorder + rootIndex + 1, inorderSize - rootIndex - 1, postorder + rootIndex, postorderSize - rootIndex - 1);

    return root;
}