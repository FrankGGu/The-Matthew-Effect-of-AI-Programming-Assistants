#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxTargetNodes(struct TreeNode* root, struct TreeNode* target, int amount) {
    if (!root) return 0;

    int leftCount = maxTargetNodes(root->left, target, amount);
    int rightCount = maxTargetNodes(root->right, target, amount);

    if (root == target) {
        return leftCount + rightCount + 1;
    } else {
        if (root->val > target->val) {
            if (amount > 0) {
                return maxTargetNodes(root->left, target, amount - 1);
            } else {
                return 0;
            }
        } else {
            if (amount > 0) {
                return maxTargetNodes(root->right, target, amount - 1);
            } else {
                return 0;
            }
        }
    }
}