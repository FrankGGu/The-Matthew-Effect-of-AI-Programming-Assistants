#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findMode(struct TreeNode* root, int* returnSize) {
    int count = 1;
    int maxCount = 0;
    int prev = -100001;
    int* modes = NULL;
    int modesSize = 0;

    void inorder(struct TreeNode* node) {
        if (!node) return;

        inorder(node->left);

        if (node->val == prev) {
            count++;
        } else {
            count = 1;
        }

        if (count > maxCount) {
            maxCount = count;
            modesSize = 1;
            modes = (int*)malloc(sizeof(int));
            modes[0] = node->val;
        } else if (count == maxCount) {
            modesSize++;
            modes = (int*)realloc(modes, modesSize * sizeof(int));
            modes[modesSize - 1] = node->val;
        }

        prev = node->val;

        inorder(node->right);
    }

    inorder(root);
    *returnSize = modesSize;
    return modes;
}