int* largestValues(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int capacity = 10;
    int* result = (int*)malloc(capacity * sizeof(int));
    int front = 0, rear = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(capacity * sizeof(struct TreeNode*));
    queue[rear++] = root;
    *returnSize = 0;

    while (front < rear) {
        int maxVal = INT_MIN;
        int count = rear - front;

        for (int i = 0; i < count; i++) {
            struct TreeNode* node = queue[front++];
            if (node->val > maxVal) {
                maxVal = node->val;
            }
            if (node->left) {
                queue[rear++] = node->left;
            }
            if (node->right) {
                queue[rear++] = node->right;
            }
        }

        if (*returnSize >= capacity) {
            capacity *= 2;
            result = (int*)realloc(result, capacity * sizeof(int));
        }
        result[(*returnSize)++] = maxVal;
    }

    free(queue);
    return result;
}