#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* trainingPlan(struct TreeNode* root, int* voyage, int voyageSize, int* index) {
    if (root == NULL) {
        return root;
    }

    if (root->val != voyage[*index]) {
        return NULL;
    }

    (*index)++;

    if (root->left != NULL && root->right != NULL) {
        if (root->left->val != voyage[*index]) {
            struct TreeNode* temp = root->left;
            root->left = root->right;
            root->right = temp;
        }
    }

    root->left = trainingPlan(root->left, voyage, voyageSize, index);
    root->right = trainingPlan(root->right, voyage, voyageSize, index);

    return root;
}

struct TreeNode* flipEquiv(struct TreeNode* root, int* voyage, int voyageSize) {
    int index = 0;
    return trainingPlan(root, voyage, voyageSize, &index);
}