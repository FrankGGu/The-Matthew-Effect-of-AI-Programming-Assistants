#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int minCostToMakePathEqual(TreeNode* root) {
    if (!root) return 0;

    int leftCost = minCostToMakePathEqual(root->left);
    int rightCost = minCostToMakePathEqual(root->right);

    int maxDepth = (leftCost > rightCost) ? leftCost : rightCost;
    int cost = (leftCost + rightCost) + maxDepth;

    return cost + 1;
}