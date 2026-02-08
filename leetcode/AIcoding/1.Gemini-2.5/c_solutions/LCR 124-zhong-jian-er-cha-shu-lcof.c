#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int findIndex(int* arr, int start, int end, int target) {
    for (int i = start; i <= end; i++) {
        if (arr[i] == target) {
            return i;
        }
    }
    return -1;
}

struct TreeNode* build(int* preorder, int preStart, int preEnd, int* inorder, int inStart, int inEnd) {
    if (preStart > preEnd || inStart > inEnd) {
        return NULL;
    }

    int rootVal = preorder[preStart];
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = rootVal;
    root->left = NULL;
    root->right = NULL;

    int rootIndexInorder = findIndex(inorder, inStart, inEnd, rootVal);

    int leftSubtreeSize = rootIndexInorder - inStart;

    root->left = build(preorder, preStart + 1, preStart + leftSubtreeSize,
                       inorder, inStart, rootIndexInorder - 1);

    root->right = build(preorder, preStart + leftSubtreeSize + 1, preEnd,
                        inorder, rootIndexInorder + 1, inEnd);

    return root;
}

struct TreeNode* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize) {
    if (preorderSize == 0 || inorderSize == 0) {
        return NULL;
    }
    return build(preorder, 0, preorderSize - 1, inorder, 0, inorderSize - 1);
}