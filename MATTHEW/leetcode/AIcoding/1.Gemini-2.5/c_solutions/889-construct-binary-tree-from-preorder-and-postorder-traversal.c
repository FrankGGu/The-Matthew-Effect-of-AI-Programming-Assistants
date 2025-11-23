#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTreeRecursive(int* preorder, int preStart, int preEnd, int* postorder, int postStart, int postEnd) {
    if (preStart > preEnd || postStart > postEnd) {
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[preStart];
    root->left = NULL;
    root->right = NULL;

    if (preStart == preEnd) {
        return root;
    }

    int leftRootVal = preorder[preStart + 1];

    int postIdx_leftRoot = -1;
    for (int i = postStart; i <= postEnd; ++i) {
        if (postorder[i] == leftRootVal) {
            postIdx_leftRoot = i;
            break;
        }
    }

    int len_left_subtree = postIdx_leftRoot - postStart + 1;

    root->left = buildTreeRecursive(
        preorder,
        preStart + 1,
        preStart + len_left_subtree,
        postorder,
        postStart,
        postIdx_leftRoot
    );

    root->right = buildTreeRecursive(
        preorder,
        preStart + len_left_subtree + 1,
        preEnd,
        postorder,
        postIdx_leftRoot + 1,
        postEnd - 1
    );

    return root;
}

struct TreeNode* constructFromPrePost(int* preorder, int preorderSize, int* postorder, int postorderSize) {
    if (preorderSize == 0 || postorderSize == 0) {
        return NULL;
    }

    return buildTreeRecursive(preorder, 0, preorderSize - 1, postorder, 0, postorderSize - 1);
}