int* rightSideView(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode** queue = malloc(100 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;

    int* result = malloc(100 * sizeof(int));
    *returnSize = 0;

    while (front < rear) {
        int levelSize = rear - front;
        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            if (i == levelSize - 1) {
                result[(*returnSize)++] = node->val;
            }
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
    }

    free(queue);
    return result;
}