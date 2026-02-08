#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* constructMaximumBinaryTree(int* nums, int numsSize) {
    if (numsSize == 0) return NULL;
    int maxVal = nums[0], maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
            maxIndex = i;
        }
    }
    TreeNode* root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = maxVal;
    root->left = constructMaximumBinaryTree(nums, maxIndex);
    root->right = constructMaximumBinaryTree(nums + maxIndex + 1, numsSize - maxIndex - 1);
    return root;
}

TreeNode* deleteNode(TreeNode* root, int key) {
    if (!root) return NULL;
    if (root->val > key) {
        root->left = deleteNode(root->left, key);
    } else if (root->val < key) {
        root->right = deleteNode(root->right, key);
    } else {
        if (!root->left) {
            TreeNode* temp = root->right;
            free(root);
            return temp;
        } else if (!root->right) {
            TreeNode* temp = root->left;
            free(root);
            return temp;
        } else {
            TreeNode* temp = root->right;
            while (temp->left) temp = temp->left;
            root->val = temp->val;
            root->right = deleteNode(root->right, temp->val);
        }
    }
    return root;
}

TreeNode* insertIntoMaxTree(TreeNode* root, int val) {
    if (!root || val > root->val) {
        TreeNode* newRoot = (TreeNode*)malloc(sizeof(TreeNode));
        newRoot->val = val;
        newRoot->left = root;
        return newRoot;
    }
    root->right = insertIntoMaxTree(root->right, val);
    return root;
}

TreeNode* searchBST(TreeNode* root, int val) {
    if (!root || root->val == val) return root;
    return (val < root->val) ? searchBST(root->left, val) : searchBST(root->right, val);
}

TreeNode* mergeTrees(TreeNode* root1, TreeNode* root2) {
    if (!root1) return root2;
    if (!root2) return root1;
    root1->val += root2->val;
    root1->left = mergeTrees(root1->left, root2->left);
    root1->right = mergeTrees(root1->right, root2->right);
    return root1;
}

TreeNode* trimBST(TreeNode* root, int low, int high) {
    if (!root) return NULL;
    if (root->val < low) return trimBST(root->right, low, high);
    if (root->val > high) return trimBST(root->left, low, high);
    root->left = trimBST(root->left, low, high);
    root->right = trimBST(root->right, low, high);
    return root;
}

TreeNode* constructMaximumBinaryTreeII(TreeNode* root, int val) {
    if (!root) {
        TreeNode* newRoot = (TreeNode*)malloc(sizeof(TreeNode));
        newRoot->val = val;
        return newRoot;
    }
    if (val > root->val) {
        TreeNode* newRoot = (TreeNode*)malloc(sizeof(TreeNode));
        newRoot->val = val;
        newRoot->left = root;
        return newRoot;
    }
    root->right = constructMaximumBinaryTreeII(root->right, val);
    return root;
}

TreeNode* maximumBinaryTree(TreeNode* root, int val) {
    return constructMaximumBinaryTreeII(root, val);
}