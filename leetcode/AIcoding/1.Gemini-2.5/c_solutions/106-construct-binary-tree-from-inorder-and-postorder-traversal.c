#include <stdlib.h> // For malloc

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTreeRecursive(int* inorder, int inStart, int inEnd, int* postorder, int postStart, int postEnd);

struct TreeNode* buildTree(int* inorder, int inorderSize, int* postorder, int postorderSize) {
    if (inorderSize == 0 || postorderSize == 0) {
        return NULL;
    }
    return buildTreeRecursive(inorder, 0, inorderSize - 1, postorder, 0, postorderSize - 1);
}

struct TreeNode* buildTreeRecursive(int* inorder, int inStart, int inEnd, int* postorder, int postStart, int postEnd) {
    if (inStart > inEnd || postStart > postEnd) {
        return NULL;
    }

    int rootVal = postorder[postEnd];
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = rootVal;
    root->left = NULL;
    root->right = NULL;

    int rootInIndex = -1;
    for (int i = inStart; i <= inEnd; i++) {
        if (inorder[i] == rootVal) {
            rootInIndex = i;
            break;
        }
    }

    int leftSubtreeSize = rootInIndex - inStart;

    root->left = buildTreeRecursive(inorder, inStart, rootInIndex - 1,
                                    postorder, postStart, postStart + leftSubtreeSize - 1);

    root->right = buildTreeRecursive(inorder, rootInIndex + 1, inEnd,
                                     postorder, postStart + leftSubtreeSize, postEnd - 1);

    return root;
}