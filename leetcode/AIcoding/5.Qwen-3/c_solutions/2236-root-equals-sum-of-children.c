#include <stdbool.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool rootEqualsSumOfChildren(struct TreeNode* root) {
    return (root->left->val + root->right->val) == root->val;
}