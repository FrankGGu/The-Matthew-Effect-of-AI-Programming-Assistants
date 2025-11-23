#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int kthSmallest(struct TreeNode* root, int k) {
    int count = 0;
    int result = 0;

    struct TreeNode* stack[10000];
    int top = -1;
    struct TreeNode* curr = root;

    while (curr != NULL || top != -1) {
        while (curr != NULL) {
            stack[++top] = curr;
            curr = curr->left;
        }

        curr = stack[top--];
        count++;

        if (count == k) {
            result = curr->val;
            break;
        }

        curr = curr->right;
    }

    return result;
}