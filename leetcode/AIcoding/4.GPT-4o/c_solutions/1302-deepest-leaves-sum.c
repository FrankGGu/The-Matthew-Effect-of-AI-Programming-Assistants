int deepestLeavesSum(struct TreeNode* root) {
    if (!root) return 0;

    int sum = 0, maxDepth = 0;
    struct TreeNode** queue = malloc(1000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;

    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        sum = 0;
        maxDepth++;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            sum += node->val;
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
    }

    free(queue);
    return sum;
}