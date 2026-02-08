#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int** levelOrderBottom(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode** queue = (struct TreeNode**)malloc(2000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;

    int** result = (int**)malloc(2000 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(2000 * sizeof(int));
    int level = 0;

    while (front < rear) {
        int levelSize = rear - front;
        (*returnColumnSizes)[level] = levelSize;
        result[level] = (int*)malloc(levelSize * sizeof(int));

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            result[level][i] = node->val;

            if (node->left != NULL) {
                queue[rear++] = node->left;
            }
            if (node->right != NULL) {
                queue[rear++] = node->right;
            }
        }
        level++;
    }

    *returnSize = level;

    for (int i = 0; i < level / 2; i++) {
        int* temp = result[i];
        result[i] = result[level - 1 - i];
        result[level - 1 - i] = temp;

        int tempSize = (*returnColumnSizes)[i];
        (*returnColumnSizes)[i] = (*returnColumnSizes)[level - 1 - i];
        (*returnColumnSizes)[level - 1 - i] = tempSize;
    }

    free(queue);
    return result;
}