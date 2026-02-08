#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int deepestLeavesSum(struct TreeNode* root) {
    int sum = 0;
    int maxDepth = 0;

    void traverse(struct TreeNode* node, int depth) {
        if (!node) return;

        if (!node->left && !node->right) {
            if (depth > maxDepth) {
                maxDepth = depth;
                sum = node->val;
            } else if (depth == maxDepth) {
                sum += node->val;
            }
        }

        traverse(node->left, depth + 1);
        traverse(node->right, depth + 1);
    }

    traverse(root, 0);
    return sum;
}