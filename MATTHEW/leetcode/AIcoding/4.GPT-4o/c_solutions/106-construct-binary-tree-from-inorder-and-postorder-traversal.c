struct TreeNode* buildTreeUtil(int* inorder, int* postorder, int inStart, int inEnd, int* postIndex, int size, int* inMap) {
    if (inStart > inEnd) return NULL;

    int rootVal = postorder[*postIndex];
    (*postIndex)--;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = rootVal;
    root->left = root->right = NULL;

    if (inStart == inEnd) return root;

    int inIndex = inMap[rootVal];

    root->right = buildTreeUtil(inorder, postorder, inIndex + 1, inEnd, postIndex, size, inMap);
    root->left = buildTreeUtil(inorder, postorder, inStart, inIndex - 1, postIndex, size, inMap);

    return root;
}

struct TreeNode* buildTree(int* inorder, int inorderSize, int* postorder, int postorderSize) {
    int postIndex = postorderSize - 1;
    int* inMap = (int*)malloc(inorderSize * sizeof(int));
    for (int i = 0; i < inorderSize; i++) {
        inMap[inorder[i]] = i;
    }
    return buildTreeUtil(inorder, postorder, 0, inorderSize - 1, &postIndex, inorderSize, inMap);
}