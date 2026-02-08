#define MAX_NODES 10000

int* largestValues(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode* queue[MAX_NODES];
    int front = 0, rear = 0;
    queue[rear++] = root;

    int* result = malloc(MAX_NODES * sizeof(int));
    *returnSize = 0;

    while (front < rear) {
        int levelSize = rear - front;
        int maxVal = INT_MIN;

        for (int i = 0; i < levelSize; i++) {
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

        result[(*returnSize)++] = maxVal;
    }

    return result;
}