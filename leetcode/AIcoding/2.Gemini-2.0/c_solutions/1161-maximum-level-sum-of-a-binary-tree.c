#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLevelSum(struct TreeNode* root){
    if (!root) return 0;

    int maxSum = INT_MIN;
    int maxLevel = 0;
    int currentLevel = 1;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 10000);
    int head = 0;
    int tail = 0;

    queue[tail++] = root;

    while (head < tail) {
        int levelSize = tail - head;
        int levelSum = 0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[head++];
            levelSum += node->val;

            if (node->left) {
                queue[tail++] = node->left;
            }
            if (node->right) {
                queue[tail++] = node->right;
            }
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