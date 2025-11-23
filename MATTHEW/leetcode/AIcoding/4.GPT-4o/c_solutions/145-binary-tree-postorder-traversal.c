void postorder(struct TreeNode* root, int* returnSize, int* returnArray) {
    if (!root) return;
    postorder(root->left, returnSize, returnArray);
    postorder(root->right, returnSize, returnArray);
    returnArray[(*returnSize)++] = root->val;
}

int* postorderTraversal(struct TreeNode* root, int* returnSize) {
    int* returnArray = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;
    postorder(root, returnSize, returnArray);
    return returnArray;
}