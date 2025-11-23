#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int getHeight(TreeNode* root) {
    if (!root) return 0;
    int left = getHeight(root->left);
    int right = getHeight(root->right);
    return 1 + (left > right ? left : right);
}

void dfs(TreeNode* root, int parentHeight, int* result, int* depthMap, int* heightMap) {
    if (!root) return;
    int currentHeight = 1 + (depthMap[root->val] > heightMap[root->val] ? depthMap[root->val] : heightMap[root->val]);
    result[root->val] = parentHeight;
    dfs(root->left, currentHeight, result, depthMap, heightMap);
    dfs(root->right, currentHeight, result, depthMap, heightMap);
}

int* treeQueries(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    int* depthMap = (int*)calloc(10001, sizeof(int));
    int* heightMap = (int*)calloc(10001, sizeof(int));
    int maxVal = 0;

    void dfs1(TreeNode* node, int depth, int parent) {
        if (!node) return;
        depthMap[node->val] = depth;
        int left = 0, right = 0;
        if (node->left) left = dfs1(node->left, depth + 1, node->val);
        if (node->right) right = dfs1(node->right, depth + 1, node->val);
        heightMap[node->val] = 1 + (left > right ? left : right);
        maxVal = (node->val > maxVal) ? node->val : maxVal;
        return;
    }

    dfs1(root, 0, -1);

    int* result = (int*)calloc(maxVal + 1, sizeof(int));

    void dfs2(TreeNode* node, int parentHeight) {
        if (!node) return;
        result[node->val] = parentHeight;
        int leftHeight = 0, rightHeight = 0;
        if (node->left) leftHeight = heightMap[node->left->val];
        if (node->right) rightHeight = heightMap[node->right->val];
        int newParentHeight = 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
        dfs2(node->left, newParentHeight);
        dfs2(node->right, newParentHeight);
    }

    dfs2(root, 0);

    *returnSize = queriesSize;
    int* output = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        output[i] = result[queries[i]];
    }

    free(depthMap);
    free(heightMap);
    free(result);

    return output;
}