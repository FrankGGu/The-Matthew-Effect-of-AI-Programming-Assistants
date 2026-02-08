bool findTarget(struct TreeNode* root, int k) {
    if (!root) return false;
    struct TreeNode** stack = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    int top = -1;
    struct TreeNode** stack2 = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    int top2 = -1;
    struct TreeNode* curr = root;

    while (curr || top >= 0) {
        while (curr) {
            stack[++top] = curr;
            curr = curr->left;
        }
        curr = stack[top--];

        while (curr) {
            stack2[++top2] = curr;
            curr = curr->right;
        }
        curr = stack2[top2--];

        if (top >= 0 && top2 >= 0) {
            int sum = stack[top]->val + stack2[top2]->val;
            if (sum == k) {
                free(stack);
                free(stack2);
                return true;
            }
            if (sum < k) {
                curr = stack[top--]->right;
            } else {
                curr = stack2[top2--]->left;
            }
        } else {
            break;
        }
    }

    free(stack);
    free(stack2);
    return false;
}