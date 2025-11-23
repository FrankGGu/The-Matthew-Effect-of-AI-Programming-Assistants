#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int* findTarget(struct TreeNode* root, int target, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 0;

    int* hashSet = NULL;
    int hashSetSize = 0;

    void dfs(struct TreeNode* node) {
        if (!node) return;
        dfs(node->left);
        int complement = target - node->val;
        for (int i = 0; i < hashSetSize; i++) {
            if (hashSet[i] == complement) {
                result[0] = complement;
                result[1] = node->val;
                *returnSize = 2;
                return;
            }
        }
        hashSet = (int*)realloc(hashSet, (hashSetSize + 1) * sizeof(int));
        hashSet[hashSetSize++] = node->val;
        dfs(node->right);
    }

    dfs(root);
    return result;
}