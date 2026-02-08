double* averageOfLevels(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    double* averages = (double*)malloc(100 * sizeof(double));
    int* counts = (int*)malloc(100 * sizeof(int));
    int front = 0, rear = 0;
    struct TreeNode** queue = (struct TreeNode**)malloc(100 * sizeof(struct TreeNode*));

    queue[rear++] = root;
    int level = 0;

    while (front < rear) {
        int levelSize = rear - front;
        double sum = 0;
        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            sum += node->val;
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        averages[level] = sum / levelSize;
        counts[level++] = levelSize;
    }

    *returnSize = level;
    averages = (double*)realloc(averages, level * sizeof(double));
    free(counts);
    free(queue);
    return averages;
}