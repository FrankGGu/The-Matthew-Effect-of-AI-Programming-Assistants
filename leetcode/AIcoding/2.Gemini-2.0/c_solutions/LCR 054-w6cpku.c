#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode* convertBST(struct TreeNode* root){
    int sum = 0;

    void inorder(struct TreeNode* node) {
        if (node == NULL) return;
        inorder(node->right);
        sum += node->val;
        node->val = sum;
        inorder(node->left);
    }

    inorder(root);
    return root;
}