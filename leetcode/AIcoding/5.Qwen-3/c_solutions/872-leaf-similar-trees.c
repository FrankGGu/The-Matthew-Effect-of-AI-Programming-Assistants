#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void getLeafValues(struct TreeNode* root, int** arr, int* size) {
    if (!root) return;
    if (!root->left && !root->right) {
        *arr = (int*)realloc(*arr, (*size + 1) * sizeof(int));
        (*arr)[*size] = root->val;
        (*size)++;
        return;
    }
    getLeafValues(root->left, arr, size);
    getLeafValues(root->right, arr, size);
}

bool leafSimilar(struct TreeNode* root1, struct TreeNode* root2) {
    int size1 = 0, size2 = 0;
    int* leaves1 = NULL;
    int* leaves2 = NULL;

    getLeafValues(root1, &leaves1, &size1);
    getLeafValues(root2, &leaves2, &size2);

    if (size1 != size2) {
        free(leaves1);
        free(leaves2);
        return false;
    }

    for (int i = 0; i < size1; i++) {
        if (leaves1[i] != leaves2[i]) {
            free(leaves1);
            free(leaves2);
            return false;
        }
    }

    free(leaves1);
    free(leaves2);
    return true;
}