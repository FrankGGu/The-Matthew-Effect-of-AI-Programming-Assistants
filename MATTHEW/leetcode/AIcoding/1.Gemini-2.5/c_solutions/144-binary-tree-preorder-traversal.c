void preorderTraversalRecursive(struct TreeNode* root, int* result, int* index) {
    if (root == NULL) {
        return;
    }
    result[*index] = root->val;
    (*index)++;
    preorderTraversalRecursive(root->left, result, index);
    preorderTraversalRecursive(root->right, result, index);
}

int* preorderTraversal(struct TreeNode* root, int* returnSize) {
    int* result = NULL;
    *returnSize = 0;

    if (root == NULL) {
        return result;
    }

    // First, count the number of nodes to allocate memory
    int count = 0;
    struct TreeNode** stack = (struct TreeNode**)malloc(100 * sizeof(struct TreeNode*)); // Max 100 nodes for initial estimate
    int top = -1;

    if (root != NULL) {
        stack[++top] = root;
        while (top != -1) {
            struct TreeNode* current = stack[top--];
            count++;
            if (current->right != NULL) {
                stack[++top] = current->right;
            }
            if (current->left != NULL) {
                stack[++top] = current->left;
            }
        }
    }
    free(stack); // Free the temporary stack used for counting

    result = (int*)malloc(count * sizeof(int));
    *returnSize = 0; // Reset returnSize for actual population

    // Now, perform the actual traversal and fill the result array
    preorderTraversalRecursive(root, result, returnSize);

    return result;
}