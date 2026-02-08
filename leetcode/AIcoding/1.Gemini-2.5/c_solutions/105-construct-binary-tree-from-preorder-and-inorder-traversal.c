#include <stdlib.h> // For malloc

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

static struct TreeNode* buildTreeHelper(int* preorder, int preStart, int preEnd,
                                        int* inorder, int inStart, int inEnd) {
    if (preStart > preEnd || inStart > inEnd) {
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = preorder[preStart];
    root->left = NULL;
    root->right = NULL;

    int rootInorderIndex = -1;
    for (int i = inStart; i <= inEnd; ++i) {
        if (inorder[i] == root->val) {
            rootInorderIndex = i;
            break;
        }
    }

    int leftSubtreeSize = rootInorderIndex - inStart;

    root->left = buildTreeHelper(preorder, preStart + 1, preStart + leftSubtreeSize,
                                 inorder, inStart, rootInorderIndex - 1);

    root->right = buildTreeHelper(preorder, preStart + leftSubtreeSize + 1, preEnd,
                                  inorder, rootInorderIndex + 1, inEnd);

    return root;
}

struct TreeNode* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize) {
    if (preorderSize == 0 || inorderSize == 0) {
        return NULL;
    }
    return buildTreeHelper(preorder, 0, preorderSize - 1,
                           inorder, 0, inorderSize - 1);
}