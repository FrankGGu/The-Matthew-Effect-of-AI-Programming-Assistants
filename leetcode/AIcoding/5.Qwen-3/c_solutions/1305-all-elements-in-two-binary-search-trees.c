#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* getAllElements(struct TreeNode* root1, struct TreeNode* root2, int* returnSize) {
    int* arr1 = (int*)malloc(0);
    int* arr2 = (int*)malloc(0);
    int size1 = 0, size2 = 0;

    void inorder(struct TreeNode* root, int** arr, int* size) {
        if (!root) return;
        inorder(root->left, arr, size);
        (*arr) = (int*)realloc(*arr, (*size + 1) * sizeof(int));
        (*arr)[*size] = root->val;
        (*size)++;
        inorder(root->right, arr, size);
    }

    inorder(root1, &arr1, &size1);
    inorder(root2, &arr2, &size2);

    int* result = (int*)malloc((size1 + size2) * sizeof(int));
    int index = 0;
    for (int i = 0; i < size1; i++) {
        result[index++] = arr1[i];
    }
    for (int i = 0; i < size2; i++) {
        result[index++] = arr2[i];
    }

    qsort(result, size1 + size2, sizeof(int), compare);
    *returnSize = size1 + size2;

    free(arr1);
    free(arr2);

    return result;
}