#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int val;
    struct TreeNode* left;
    struct TreeNode* right;
} TreeNode;

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

int getDepth(TreeNode* root, int target, int depth) {
    if (!root) return -1;
    if (root->val == target) return depth;
    int left = getDepth(root->left, target, depth + 1);
    if (left != -1) return left;
    return getDepth(root->right, target, depth + 1);
}

int findLCA(TreeNode* root, int a, int b) {
    if (!root) return -1;
    if (root->val == a || root->val == b) return root->val;
    int leftLCA = findLCA(root->left, a, b);
    int rightLCA = findLCA(root->right, a, b);
    if (leftLCA != -1 && rightLCA != -1) return root->val;
    return (leftLCA != -1) ? leftLCA : rightLCA;
}

int* cycleLengthQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    TreeNode* root = createTreeNode(1);
    for (int i = 2; i <= n; i++) {
        TreeNode* current = root;
        while (current) {
            if (i < current->val) {
                if (!current->left) {
                    current->left = createTreeNode(i);
                    break;
                }
                current = current->left;
            } else {
                if (!current->right) {
                    current->right = createTreeNode(i);
                    break;
                }
                current = current->right;
            }
        }
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int b = queries[i][1];
        int lca = findLCA(root, a, b);
        int depthA = getDepth(root, a, 0);
        int depthB = getDepth(root, b, 0);
        int depthLCA = getDepth(root, lca, 0);
        result[i] = (depthA - depthLCA) + (depthB - depthLCA) + 1;
    }

    return result;
}