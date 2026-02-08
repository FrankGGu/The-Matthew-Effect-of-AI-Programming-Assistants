#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node** children;
    int numChildren;
} Node;

int* postorder(struct Node* root, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 10000);
    *returnSize = 0;

    void dfs(struct Node* node) {
        if (!node) return;
        for (int i = 0; i < node->numChildren; i++) {
            dfs(node->children[i]);
        }
        result[(*returnSize)++] = node->val;
    }

    dfs(root);
    return result;
}