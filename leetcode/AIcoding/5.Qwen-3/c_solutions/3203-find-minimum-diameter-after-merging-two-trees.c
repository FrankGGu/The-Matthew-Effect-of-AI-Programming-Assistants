#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int height;
    int diameter;
} Result;

Result* getDiameterAndHeight(TreeNode* root) {
    if (!root) {
        Result* res = (Result*)malloc(sizeof(Result));
        res->height = 0;
        res->diameter = 0;
        return res;
    }

    Result* left = getDiameterAndHeight(root->left);
    Result* right = getDiameterAndHeight(root->right);

    int currentHeight = 1 + (left->height > right->height ? left->height : right->height);
    int currentDiameter = left->height + right->height + 1;
    int maxDiameter = (left->diameter > right->diameter) ? left->diameter : right->diameter;
    currentDiameter = (currentDiameter > maxDiameter) ? currentDiameter : maxDiameter;

    Result* res = (Result*)malloc(sizeof(Result));
    res->height = currentHeight;
    res->diameter = currentDiameter;

    free(left);
    free(right);

    return res;
}

int treeMinDiameter(TreeNode* root1, TreeNode* root2) {
    Result* res1 = getDiameterAndHeight(root1);
    Result* res2 = getDiameterAndHeight(root2);

    int maxDiameter = (res1->diameter > res2->diameter) ? res1->diameter : res2->diameter;

    free(res1);
    free(res2);

    return maxDiameter;
}