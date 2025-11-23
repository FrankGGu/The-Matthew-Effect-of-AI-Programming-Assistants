#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* mergeBSTs(struct TreeNode** bst1, struct TreeNode** bst2, int size) {
    int* arr1 = NULL;
    int* arr2 = NULL;
    int count1 = 0, count2 = 0;

    void inorder(struct TreeNode* root, int** arr, int* count) {
        if (!root) return;
        inorder(root->left, arr, count);
        *arr = (int*)realloc(*arr, (*count + 1) * sizeof(int));
        (*arr)[*count] = root->val;
        (*count)++;
        inorder(root->right, arr, count);
    }

    inorder(*bst1, &arr1, &count1);
    inorder(*bst2, &arr2, &count2);

    int* merged = (int*)malloc((count1 + count2) * sizeof(int));
    int i = 0, j = 0, k = 0;
    while (i < count1 && j < count2) {
        if (arr1[i] < arr2[j]) {
            merged[k++] = arr1[i++];
        } else {
            merged[k++] = arr2[j++];
        }
    }
    while (i < count1) merged[k++] = arr1[i++];
    while (j < count2) merged[k++] = arr2[j++];

    free(arr1);
    free(arr2);

    struct TreeNode* root = NULL;

    void insert(struct TreeNode** node, int val) {
        if (!*node) {
            *node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            (*node)->val = val;
            (*node)->left = NULL;
            (*node)->right = NULL;
            return;
        }
        if (val < (*node)->val) insert(&(*node)->left, val);
        else insert(&(*node)->right, val);
    }

    for (int m = 0; m < k; m++) {
        insert(&root, merged[m]);
    }

    free(merged);
    return root;
}