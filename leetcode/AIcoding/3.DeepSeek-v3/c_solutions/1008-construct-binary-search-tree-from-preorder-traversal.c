int idx;

struct TreeNode* helper(int* preorder, int n, int min, int max) {
    if (idx >= n) return NULL;
    int val = preorder[idx];
    if (val < min || val > max) return NULL;

    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = val;
    idx++;

    node->left = helper(preorder, n, min, val - 1);
    node->right = helper(preorder, n, val + 1, max);

    return node;
}

struct TreeNode* bstFromPreorder(int* preorder, int preorderSize) {
    idx = 0;
    return helper(preorder, preorderSize, INT_MIN, INT_MAX);
}