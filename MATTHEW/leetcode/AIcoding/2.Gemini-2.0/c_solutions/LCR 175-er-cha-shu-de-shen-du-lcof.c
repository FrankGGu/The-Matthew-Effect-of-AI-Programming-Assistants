#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDepth(struct TreeNode* root){
    if (root == NULL) {
        return 0;
    } else {
        int left_depth = maxDepth(root->left);
        int right_depth = maxDepth(root->right);
        if (left_depth > right_depth) {
            return (left_depth + 1);
        } else {
            return (right_depth + 1);
        }
    }
}