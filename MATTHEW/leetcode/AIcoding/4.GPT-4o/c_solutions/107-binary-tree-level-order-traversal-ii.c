void levelOrder(struct TreeNode* root, int*** result, int* returnSize, int** returnColumnSizes) {
    if (!root) {
        *returnSize = 0;
        return;
    }

    int capacity = 100;
    int** res = malloc(capacity * sizeof(int*));
    int* sizes = malloc(capacity * sizeof(int));
    int front = 0, rear = 0;
    struct TreeNode** queue = malloc(1000 * sizeof(struct TreeNode*));
    queue[rear++] = root;

    while (front < rear) {
        int count = rear - front;
        if (*returnSize >= capacity) {
            capacity *= 2;
            res = realloc(res, capacity * sizeof(int*));
            sizes = realloc(sizes, capacity * sizeof(int));
        }
        res[*returnSize] = malloc(count * sizeof(int));
        sizes[*returnSize] = count;

        for (int i = 0; i < count; i++) {
            struct TreeNode* node = queue[front++];
            res[*returnSize][i] = node->val;
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        (*returnSize)++;
    }

    *returnColumnSizes = sizes;
    *result = res;

    for (int i = 0; i < *returnSize / 2; i++) {
        int* temp = res[i];
        res[i] = res[*returnSize - 1 - i];
        res[*returnSize - 1 - i] = temp;
    }

    free(queue);
}

int** levelOrderBottom(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    int** result;
    levelOrder(root, &result, returnSize, returnColumnSizes);
    return result;
}