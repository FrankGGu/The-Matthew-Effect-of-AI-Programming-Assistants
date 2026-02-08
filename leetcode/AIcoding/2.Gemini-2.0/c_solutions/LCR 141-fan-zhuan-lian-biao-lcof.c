#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* trainingPlan(struct TreeNode* root, int target, int* returnSize) {
    int* path = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    if (root == NULL) {
        return path;
    }

    void findPath(struct TreeNode* node, int target, int* path, int* returnSize, int found) {
        if(found == 1) return;

        if (node == NULL) {
            return;
        }

        path[(*returnSize)++] = node->val;

        if (node->val == target) {
            return;
        }

        findPath(node->left, target, path, returnSize, node->left != NULL && path[*returnSize - 1] != target ? 0 : 1);
        if (path[*returnSize - 1] != target){
            findPath(node->right, target, path, returnSize, node->right != NULL && path[*returnSize - 1] != target ? 0 : 1);
        }

        if (path[*returnSize - 1] != target) {
            (*returnSize)--;
        }
    }

    findPath(root, target, path, returnSize, 0);

    return path;
}