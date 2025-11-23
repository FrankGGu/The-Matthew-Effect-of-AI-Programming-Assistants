#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    int val;
    int numChildren;
    struct Node **children;
};

void preorder_recursive(struct Node* root, int* result, int* index) {
    if (root == NULL) {
        return;
    }

    result[(*index)++] = root->val;

    for (int i = 0; i < root->numChildren; i++) {
        preorder_recursive(root->children[i], result, index);
    }
}

int* preorder(struct Node* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(10000 * sizeof(int));
    *returnSize = 0;
    int index = 0;

    preorder_recursive(root, result, &index);

    *returnSize = index;
    return result;
}