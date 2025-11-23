int* preorderTraversal(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int* result = malloc(100 * sizeof(int));
    struct TreeNode* stack[100];
    int top = -1;
    int count = 0;

    stack[++top] = root;
    while (top >= 0) {
        struct TreeNode* node = stack[top--];
        result[count++] = node->val;

        if (node->right) stack[++top] = node->right;
        if (node->left) stack[++top] = node->left;
    }

    *returnSize = count;
    return result;
}