#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTreeHelper(int* preorder, int preorderSize, int* inorder, int inorderSize, int* preIndex, int inStart, int inEnd) {
    if (inStart > inEnd) {
        return NULL;
    }

    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = preorder[*preIndex];
    (*preIndex)++;
    node->left = NULL;
    node->right = NULL;

    if (inStart == inEnd) {
        return node;
    }

    int inIndex = inStart;
    while (inIndex <= inEnd && inorder[inIndex] != node->val) {
        inIndex++;
    }

    node->left = buildTreeHelper(preorder, preorderSize, inorder, inorderSize, preIndex, inStart, inIndex - 1);
    node->right = buildTreeHelper(preorder, preorderSize, inorder, inorderSize, preIndex, inIndex + 1, inEnd);

    return node;
}

struct TreeNode* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize) {
    int preIndex = 0;
    return buildTreeHelper(preorder, preorderSize, inorder, inorderSize, &preIndex, 0, inorderSize - 1);
}