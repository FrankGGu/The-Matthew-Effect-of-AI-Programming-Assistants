#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void inorder(struct TreeNode* root, int* arr, int* size) {
    if (root == NULL) return;
    inorder(root->left, arr, size);
    arr[(*size)++] = root->val;
    inorder(root->right, arr, size);
}

int* getAllElements(struct TreeNode* root1, struct TreeNode* root2, int* returnSize){
    int size1 = 0, size2 = 0;
    int* arr1 = (int*)malloc(sizeof(int) * 10000);
    int* arr2 = (int*)malloc(sizeof(int) * 10000);

    inorder(root1, arr1, &size1);
    inorder(root2, arr2, &size2);

    int* result = (int*)malloc(sizeof(int) * (size1 + size2));
    int i = 0, j = 0, k = 0;

    while (i < size1 && j < size2) {
        if (arr1[i] <= arr2[j]) {
            result[k++] = arr1[i++];
        } else {
            result[k++] = arr2[j++];
        }
    }

    while (i < size1) {
        result[k++] = arr1[i++];
    }

    while (j < size2) {
        result[k++] = arr2[j++];
    }

    *returnSize = size1 + size2;
    free(arr1);
    free(arr2);
    return result;
}