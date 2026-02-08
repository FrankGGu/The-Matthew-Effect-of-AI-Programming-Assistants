#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTreeHelper(int* inorder, int inStart, int inEnd, int* postorder, int postStart, int postEnd, int* inorderIndexMap) {
    if (inStart > inEnd || postStart > postEnd) {
        return NULL;
    }

    int rootVal = postorder[postEnd];
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = rootVal;
    root->left = NULL;
    root->right = NULL;

    int rootIndex = inorderIndexMap[rootVal];

    int leftSubtreeSize = rootIndex - inStart;

    root->left = buildTreeHelper(inorder, inStart, rootIndex - 1, postorder, postStart, postStart + leftSubtreeSize - 1, inorderIndexMap);
    root->right = buildTreeHelper(inorder, rootIndex + 1, inEnd, postorder, postStart + leftSubtreeSize, postEnd - 1, inorderIndexMap);

    return root;
}

struct TreeNode* buildTree(int* inorder, int inorderSize, int* postorder, int postorderSize) {
    int* inorderIndexMap = (int*)malloc(sizeof(int) * 6001); 
    for (int i = 0; i < inorderSize; i++) {
        inorderIndexMap[inorder[i]] = i;
    }

    return buildTreeHelper(inorder, 0, inorderSize - 1, postorder, 0, postorderSize - 1, inorderIndexMap);
}