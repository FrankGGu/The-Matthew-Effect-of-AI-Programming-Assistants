#include <stdlib.h>

struct Node {
    int val;
    struct Node **children;
    int childrenSize;
};

void preorderHelper(struct Node* root, int** returnColumnSizes, int* returnSize, int** result) {
    if (!root) return;
    result[(*returnSize)++] = malloc(sizeof(int));
    result[*returnSize - 1][0] = root->val;

    for (int i = 0; i < root->childrenSize; i++) {
        preorderHelper(root->children[i], returnColumnSizes, returnSize, result);
    }
}

int** preorder(struct Node* root, int** returnColumnSizes, int* returnSize) {
    *returnSize = 0;
    int** result = malloc(1000 * sizeof(int*));
    preorderHelper(root, returnColumnSizes, returnSize, result);
    *returnColumnSizes = malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = 1;
    }
    return result;
}