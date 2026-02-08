#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* postorder(struct Node* root, int* returnSize) {
    int* result = NULL;
    *returnSize = 0;

    if (!root) {
        return NULL;
    }

    int capacity = 10000;
    result = (int*)malloc(capacity * sizeof(int));

    void postorderHelper(struct Node* node, int* result, int* returnSize) {
        if (!node) {
            return;
        }

        if (node->numChildren > 0) {
            for (int i = 0; i < node->numChildren; i++) {
                postorderHelper(node->children[i], result, returnSize);
            }
        }

        result[(*returnSize)++] = node->val;
    }

    postorderHelper(root, result, returnSize);

    return result;
}