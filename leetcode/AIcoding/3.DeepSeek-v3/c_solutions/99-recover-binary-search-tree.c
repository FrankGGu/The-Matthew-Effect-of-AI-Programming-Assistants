#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void recoverTree(struct TreeNode* root) {
    struct TreeNode *first = NULL, *second = NULL;
    struct TreeNode *prev = NULL, *current = root;
    struct TreeNode **stack = malloc(1000 * sizeof(struct TreeNode*));
    int top = -1;

    while (current != NULL || top != -1) {
        while (current != NULL) {
            stack[++top] = current;
            current = current->left;
        }
        current = stack[top--];

        if (prev != NULL && prev->val > current->val) {
            if (first == NULL) {
                first = prev;
            }
            second = current;
        }
        prev = current;
        current = current->right;
    }

    int temp = first->val;
    first->val = second->val;
    second->val = temp;

    free(stack);
}