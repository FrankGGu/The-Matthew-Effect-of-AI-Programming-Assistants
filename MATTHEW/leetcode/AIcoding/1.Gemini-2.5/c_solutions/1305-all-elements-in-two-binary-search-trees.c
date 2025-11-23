#include <stdlib.h>

void inorder_traverse(struct TreeNode* root, int** arr, int* capacity, int* size) {
    if (root == NULL) {
        return;
    }

    inorder_traverse(root->left, arr, capacity, size);

    if (*size == *capacity) {
        *capacity = (*capacity == 0) ? 1 : *capacity * 2;
        *arr = (int*)realloc(*arr, *capacity * sizeof(int));
    }
    (*arr)[*size] = root->val;
    (*size)++;

    inorder_traverse(root->right, arr, capacity, size);
}

int* getAllElements(struct TreeNode* root1, struct TreeNode* root2, int* returnSize) {
    int* arr1 = NULL;
    int capacity1 = 0;
    int size1 = 0;

    int* arr2 = NULL;
    int capacity2 = 0;
    int size2 = 0;

    inorder_traverse(root1, &arr1, &capacity1, &size1);
    inorder_traverse(root2, &arr2, &capacity2, &size2);

    *returnSize = size1 + size2;
    int* merged_arr = (int*)malloc(*returnSize * sizeof(int));

    int p1 = 0;
    int p2 = 0;
    int pm = 0;

    while (p1 < size1 && p2 < size2) {
        if (arr1[p1] < arr2[p2]) {
            merged_arr[pm++] = arr1[p1++];
        } else {
            merged_arr[pm++] = arr2[p2++];
        }
    }

    while (p1 < size1) {
        merged_arr[pm++] = arr1[p1++];
    }

    while (p2 < size2) {
        merged_arr[pm++] = arr2[p2++];
    }

    free(arr1);
    free(arr2);

    return merged_arr;
}