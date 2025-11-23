#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int* searchBST(TreeNode* root, int target, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 100);
    *returnSize = 0;

    TreeNode* current = root;
    while (current != NULL) {
        if (current->val == target) {
            result[*returnSize] = current->val;
            (*returnSize)++;
            break;
        } else if (current->val < target) {
            current = current->right;
        } else {
            current = current->left;
        }
    }

    return result;
}