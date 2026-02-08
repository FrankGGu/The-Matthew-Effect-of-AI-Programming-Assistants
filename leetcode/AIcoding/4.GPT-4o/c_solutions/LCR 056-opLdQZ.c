bool findTarget(struct TreeNode* root, int k) {
    struct TreeNode** stack = malloc(1000 * sizeof(struct TreeNode*));
    int top = -1;
    struct TreeNode* curr = root;
    int values[1000];
    int index = 0;

    while (curr != NULL || top != -1) {
        while (curr != NULL) {
            stack[++top] = curr;
            curr = curr->left;
        }
        curr = stack[top--];
        values[index++] = curr->val;
        curr = curr->right;
    }

    int left = 0, right = index - 1;
    while (left < right) {
        int sum = values[left] + values[right];
        if (sum == k) {
            free(stack);
            return true;
        } else if (sum < k) {
            left++;
        } else {
            right--;
        }
    }

    free(stack);
    return false;
}