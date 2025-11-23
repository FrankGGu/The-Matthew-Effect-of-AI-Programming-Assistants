#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int kthSmallest(struct TreeNode* root, int k) {
    int count = 0;
    int result = 0;

    void inorder(struct TreeNode* node) {
        if (!node || count >= k) return;
        inorder(node->left);
        count++;
        if (count == k) {
            result = node->val;
            return;
        }
        inorder(node->right);
    }

    inorder(root);
    return result;
}