#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestUnivaluePathHelper(struct TreeNode* root, int* maxLen) {
    if (!root) return 0;

    int leftLen = longestUnivaluePathHelper(root->left, maxLen);
    int rightLen = longestUnivaluePathHelper(root->right, maxLen);

    int arrowLeft = 0, arrowRight = 0;
    if (root->left && root->left->val == root->val) {
        arrowLeft += leftLen + 1;
    }
    if (root->right && root->right->val == root->val) {
        arrowRight += rightLen + 1;
    }

    *maxLen = fmax(*maxLen, arrowLeft + arrowRight);

    return fmax(arrowLeft, arrowRight);
}

int longestUnivaluePath(struct TreeNode* root) {
    int maxLen = 0;
    longestUnivaluePathHelper(root, &maxLen);
    return maxLen;
}