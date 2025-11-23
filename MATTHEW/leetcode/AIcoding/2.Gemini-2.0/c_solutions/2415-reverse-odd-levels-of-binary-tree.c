#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void reverseOddLevel(struct TreeNode* root, int level, int* arr, int* index) {
    if (!root) return;

    if (level % 2 != 0) {
        reverseOddLevel(root->right, level + 1, arr, index);
        root->val = arr[*index];
        (*index)++;
        reverseOddLevel(root->left, level + 1, arr, index);
    } else {
        reverseOddLevel(root->left, level + 1, arr, index);
        reverseOddLevel(root->right, level + 1, arr, index);
    }
}

void storeOddLevelValues(struct TreeNode* root, int level, int* arr, int* index) {
    if (!root) return;

    if (level % 2 != 0) {
        storeOddLevelValues(root->left, level + 1, arr, index);
        arr[*index] = root->val;
        (*index)++;
        storeOddLevelValues(root->right, level + 1, arr, index);
    } else {
        storeOddLevelValues(root->left, level + 1, arr, index);
        storeOddLevelValues(root->right, level + 1, arr, index);
    }
}

int countOddLevelNodes(struct TreeNode* root, int level) {
    if (!root) return 0;

    if (level % 2 != 0) {
        return 1 + countOddLevelNodes(root->left, level + 1) + countOddLevelNodes(root->right, level + 1);
    } else {
        return countOddLevelNodes(root->left, level + 1) + countOddLevelNodes(root->right, level + 1);
    }
}

struct TreeNode* reverseOddLevels(struct TreeNode* root) {
    int oddLevelNodesCount = countOddLevelNodes(root, 0);
    int* arr = (int*)malloc(sizeof(int) * oddLevelNodesCount);
    int index = 0;

    storeOddLevelValues(root, 0, arr, &index);
    index = 0;

    reverseOddLevel(root, 0, arr, &index);

    free(arr);
    return root;
}