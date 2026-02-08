#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node** children;
    int childrenSize;
} Node;

int* preorder(struct Node* root, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 10000);
    *returnSize = 0;

    if (root == NULL) {
        return result;
    }

    struct Node* stack[10000];
    int top = 0;
    stack[top++] = root;

    while (top > 0) {
        struct Node* node = stack[--top];
        result[*returnSize] = node->val;
        (*returnSize)++;

        for (int i = node->childrenSize - 1; i >= 0; i--) {
            stack[top++] = node->children[i];
        }
    }

    return result;
}