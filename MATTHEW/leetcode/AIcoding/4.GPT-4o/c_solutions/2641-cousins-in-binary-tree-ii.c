struct TreeNode* createNode(int val) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void findCousins(struct TreeNode* root, int* result, int* returnSize) {
    if (!root) return;

    struct TreeNode* queue[1000];
    int front = 0, back = 0;
    queue[back++] = root;

    while (front < back) {
        int levelSize = back - front;
        int found = 0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            if (node->left) {
                queue[back++] = node->left;
            }
            if (node->right) {
                queue[back++] = node->right;
            }
            if (node->val == result[0]) {
                found = 1;
            }
        }

        if (found) {
            for (int i = 0; i < levelSize; i++) {
                struct TreeNode* node = queue[front - levelSize + i];
                if (node->val != result[0]) {
                    result[(*returnSize)++] = node->val;
                }
            }
            return;
        }
    }
}

int* findCousinsInBinaryTree(struct TreeNode* root, int target, int* returnSize) {
    *returnSize = 0;
    int* result = (int*)malloc(100 * sizeof(int));
    result[0] = target;
    findCousins(root, result, returnSize);
    return result;
}