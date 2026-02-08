#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool evaluateTree(struct TreeNode* root) {
    if (root->left == NULL && root->right == NULL) {
        return root->val == 1;
    }

    bool leftResult = evaluateTree(root->left);
    bool rightResult = evaluateTree(root->right);

    if (root->val == 2) {
        return leftResult || rightResult;
    } else {
        return leftResult && rightResult;
    }
}