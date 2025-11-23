#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool checkTree(struct TreeNode* root){
    if (root == NULL) return true;
    if (root->left == NULL && root->right == NULL) return true;

    int sum = 0;
    if (root->left != NULL) sum += root->left->val;
    if (root->right != NULL) sum += root->right->val;

    return root->val == sum;
}