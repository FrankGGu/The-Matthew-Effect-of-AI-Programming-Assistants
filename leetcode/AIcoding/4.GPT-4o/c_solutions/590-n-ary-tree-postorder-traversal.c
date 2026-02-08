#include <stdio.h>
#include <stdlib.h>

struct Node {
    int val;
    struct Node **children;
    int childrenSize;
};

void postorderHelper(struct Node* root, int** result, int* returnSize) {
    if (root == NULL) return;
    for (int i = 0; i < root->childrenSize; i++) {
        postorderHelper(root->children[i], result, returnSize);
    }
    (*result)[(*returnSize)++] = root->val;
}

int* postorder(struct Node* root, int* returnSize) {
    int* result = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;
    postorderHelper(root, &result, returnSize);
    return result;
}