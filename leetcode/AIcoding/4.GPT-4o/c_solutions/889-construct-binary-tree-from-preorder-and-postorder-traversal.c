struct TreeNode* constructFromPrePost(int* preorder, int preorderSize, int* postorder, int postorderSize) {
    if (preorderSize == 0) return NULL;
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[0];

    if (preorderSize == 1) {
        root->left = root->right = NULL;
        return root;
    }

    int leftRoot = preorder[1];
    int leftSize = 0;

    for (int i = 0; i < postorderSize; i++) {
        if (postorder[i] == leftRoot) {
            leftSize = i + 1;
            break;
        }
    }

    root->left = constructFromPrePost(preorder + 1, leftSize, postorder, leftSize);
    root->right = constructFromPrePost(preorder + 1 + leftSize, preorderSize - 1 - leftSize, postorder + leftSize - 1, postorderSize - leftSize);

    return root;
}