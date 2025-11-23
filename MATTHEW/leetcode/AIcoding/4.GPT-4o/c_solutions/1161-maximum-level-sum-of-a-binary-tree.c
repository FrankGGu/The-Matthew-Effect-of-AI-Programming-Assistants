int maxLevelSum(struct TreeNode* root) {
    if (!root) return 0;

    int maxSum = root->val, maxLevel = 1, currentLevel = 1;
    struct TreeNode** queue = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    int front = 0, back = 0;

    queue[back++] = root;

    while (front < back) {
        int levelSum = 0, levelCount = back - front;

        for (int i = 0; i < levelCount; i++) {
            struct TreeNode* node = queue[front++];
            levelSum += node->val;
            if (node->left) queue[back++] = node->left;
            if (node->right) queue[back++] = node->right;
        }

        if (levelSum > maxSum) {
            maxSum = levelSum;
            maxLevel = currentLevel;
        }

        currentLevel++;
    }

    free(queue);
    return maxLevel;
}