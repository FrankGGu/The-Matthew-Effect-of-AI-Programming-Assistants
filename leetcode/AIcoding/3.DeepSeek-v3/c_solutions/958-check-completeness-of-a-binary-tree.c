#include <stdbool.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool isCompleteTree(struct TreeNode* root) {
    if (root == NULL) return true;

    struct TreeNode** queue = (struct TreeNode**)malloc(100 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;
    bool foundNull = false;

    while (front < rear) {
        struct TreeNode* node = queue[front++];

        if (node == NULL) {
            foundNull = true;
        } else {
            if (foundNull) {
                free(queue);
                return false;
            }
            queue[rear++] = node->left;
            queue[rear++] = node->right;
        }
    }

    free(queue);
    return true;
}