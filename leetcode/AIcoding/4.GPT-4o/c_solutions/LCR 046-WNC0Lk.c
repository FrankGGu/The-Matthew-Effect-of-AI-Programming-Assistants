int* rightSideView(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int capacity = 100;
    int* result = malloc(capacity * sizeof(int));
    int front = 0, rear = 0;
    int levelSize = 1;

    struct TreeNode** queue = malloc(capacity * sizeof(struct TreeNode*));
    queue[rear++] = root;

    while (front < rear) {
        int currentLevelSize = rear - front;
        for (int i = 0; i < currentLevelSize; i++) {
            struct TreeNode* node = queue[front++];
            if (i == currentLevelSize - 1) {
                if (*returnSize >= capacity) {
                    capacity *= 2;
                    result = realloc(result, capacity * sizeof(int));
                }
                result[(*returnSize)++] = node->val;
            }
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
    }

    free(queue);
    return result;
}