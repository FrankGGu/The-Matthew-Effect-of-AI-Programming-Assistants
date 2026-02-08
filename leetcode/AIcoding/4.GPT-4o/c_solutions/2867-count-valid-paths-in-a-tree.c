#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countPaths(struct TreeNode* node, int sum, int currentSum) {
    if (!node) return 0;
    currentSum += node->val;
    int count = (currentSum == sum) ? 1 : 0;
    count += countPaths(node->left, sum, currentSum);
    count += countPaths(node->right, sum, currentSum);
    return count;
}

int countValidPaths(struct TreeNode* root, int sum) {
    if (!root) return 0;
    return countPaths(root, sum, 0) + countValidPaths(root->left, sum) + countValidPaths(root->right, sum);
}

int countValidPathsInTree(struct TreeNode* root, int sum) {
    return countValidPaths(root, sum);
}