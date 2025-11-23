#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* findNode(struct TreeNode* root, int target) {
    if (!root) return NULL;
    if (root->val == target) return root;
    struct TreeNode* left = findNode(root->left, target);
    if (left) return left;
    return findNode(root->right, target);
}

int findPath(struct TreeNode* root, int target, char* path, int pathLen) {
    if (!root) return 0;
    if (root->val == target) {
        path[pathLen] = '\0';
        return 1;
    }
    path[pathLen] = 'L';
    if (findPath(root->left, target, path, pathLen + 1)) return 1;
    path[pathLen] = 'R';
    if (findPath(root->right, target, path, pathLen + 1)) return 1;
    return 0;
}

struct TreeNode* findLCA(struct TreeNode* root, int startValue, int destValue) {
    if (!root) return NULL;

    if (root->val == startValue || root->val == destValue) return root;

    struct TreeNode* left = findLCA(root->left, startValue, destValue);
    struct TreeNode* right = findLCA(root->right, startValue, destValue);

    if (left && right) return root;

    return left ? left : right;
}

char * getDirections(struct TreeNode* root, int startValue, int destValue){
    struct TreeNode* lca = findLCA(root, startValue, destValue);

    char* startPath = (char*)malloc(sizeof(char) * 501);
    char* destPath = (char*)malloc(sizeof(char) * 501);

    findPath(lca, startValue, startPath, 0);
    findPath(lca, destValue, destPath, 0);

    int startPathLen = strlen(startPath);
    int destPathLen = strlen(destPath);

    char* result = (char*)malloc(sizeof(char) * (startPathLen + destPathLen + 1));
    memset(result, 'U', startPathLen);
    result[startPathLen] = '\0';
    strcat(result, destPath);

    free(startPath);
    free(destPath);

    return result;
}