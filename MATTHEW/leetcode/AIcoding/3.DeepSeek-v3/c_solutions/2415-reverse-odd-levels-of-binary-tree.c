#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* reverseOddLevels(struct TreeNode* root) {
    if (!root) return NULL;

    struct TreeNode** queue = malloc(200000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;
    int level = 0;

    while (front < rear) {
        int levelSize = rear - front;
        struct TreeNode** levelNodes = malloc(levelSize * sizeof(struct TreeNode*));

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            levelNodes[i] = node;
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        if (level % 2 == 1) {
            for (int i = 0; i < levelSize / 2; i++) {
                int temp = levelNodes[i]->val;
                levelNodes[i]->val = levelNodes[levelSize - 1 - i]->val;
                levelNodes[levelSize - 1 - i]->val = temp;
            }
        }

        free(levelNodes);
        level++;
    }

    free(queue);
    return root;
}