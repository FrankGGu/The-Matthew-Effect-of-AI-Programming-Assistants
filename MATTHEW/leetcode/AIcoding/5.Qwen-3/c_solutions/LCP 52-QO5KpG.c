#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int count;
    int total;
} Result;

Result* dfs(TreeNode* root, int target) {
    Result* res = (Result*)malloc(sizeof(Result));
    res->count = 0;
    res->total = 0;

    if (!root) return res;

    Result* left = dfs(root->left, target);
    Result* right = dfs(root->right, target);

    res->count = left->count + right->count;
    res->total = left->total + right->total;

    if (root->val == target) {
        res->count++;
    }

    free(left);
    free(right);

    return res;
}

int closestValue(TreeNode* root, double target) {
    int closest = root->val;
    while (root) {
        if (fabs(target - root->val) < fabs(target - closest)) {
            closest = root->val;
        }
        if (target < root->val) {
            root = root->left;
        } else {
            root = root->right;
        }
    }
    return closest;
}

int getNumber(TreeNode* root, int n, int target) {
    Result* res = dfs(root, target);
    int count = res->count;
    free(res);
    return count;
}