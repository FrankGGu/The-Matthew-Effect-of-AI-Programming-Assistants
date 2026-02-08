#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int *values;
    int size;
} Path;

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void dfs(TreeNode* root, int currentSum, int* maxProfit) {
    if (root == NULL) return;

    currentSum += root->val;

    if (root->left == NULL && root->right == NULL) {
        if (currentSum > *maxProfit) {
            *maxProfit = currentSum;
        }
        return;
    }

    dfs(root->left, currentSum, maxProfit);
    dfs(root->right, currentSum, maxProfit);
}

int maxProfitablePath(TreeNode* root) {
    int maxProfit = -1;
    dfs(root, 0, &maxProfit);
    return maxProfit;
}