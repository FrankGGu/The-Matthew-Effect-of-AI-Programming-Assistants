#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* replaceValueInTree(struct TreeNode* root) {
    if (!root) return NULL;

    int* result = (int*)malloc(100001 * sizeof(int));
    int resultSize = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(100001 * sizeof(struct TreeNode*));
    int head = 0, tail = 0;
    queue[tail++] = root;

    while (head < tail) {
        int levelSize = tail - head;
        int levelSum = 0;
        struct TreeNode** levelNodes = (struct TreeNode**)malloc(levelSize * sizeof(struct TreeNode*));
        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[head++];
            levelNodes[i] = node;
            levelSum += node->val;

            if (node->left) queue[tail++] = node->left;
            if (node->right) queue[tail++] = node->right;
        }

        for (int i = 0; i < levelSize; i++) {
            int siblingSum = 0;
            struct TreeNode* node = levelNodes[i];

            if (node->left) siblingSum += node->left->val;
            if (node->right) siblingSum += node->right->val;

            result[resultSize++] = levelSum - siblingSum - node->val;
        }

        free(levelNodes);
    }

    free(queue);

    int* finalResult = (int*)malloc(100001 * sizeof(int));
    head = 0;
    tail = 0;
    queue = (struct TreeNode**)malloc(100001 * sizeof(struct TreeNode*));
    queue[tail++] = root;
    int idx = 0;
    while (head < tail) {
        struct TreeNode* node = queue[head++];
        finalResult[idx++] = result[idx-1];

        if (node->left) queue[tail++] = node->left;
        if (node->right) queue[tail++] = node->right;
    }
    free(queue);
    free(result);

    return finalResult;
}