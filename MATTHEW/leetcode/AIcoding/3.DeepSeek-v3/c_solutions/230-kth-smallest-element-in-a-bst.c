int kthSmallest(struct TreeNode* root, int k) {
    struct TreeNode* stack[10000];
    int top = -1;
    struct TreeNode* current = root;
    int count = 0;

    while (current != NULL || top != -1) {
        while (current != NULL) {
            stack[++top] = current;
            current = current->left;
        }

        current = stack[top--];
        count++;

        if (count == k) {
            return current->val;
        }

        current = current->right;
    }

    return -1;
}