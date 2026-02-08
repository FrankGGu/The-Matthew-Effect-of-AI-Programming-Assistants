#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void findSmallestMissing(struct TreeNode* root, int* result, int* index, int* found) {
    if (!root) return;

    found[root->val] = 1;

    findSmallestMissing(root->left, result, index, found);
    findSmallestMissing(root->right, result, index, found);
}

int smallestMissingValue(int* found, int size) {
    for (int i = 1; i <= size; i++) {
        if (!found[i]) return i;
    }
    return size + 1;
}

void dfs(struct TreeNode* root, int** result, int* returnSize) {
    if (!root) return;

    int found[1001] = {0};
    findSmallestMissing(root, result[*returnSize], NULL, found);
    result[*returnSize][0] = smallestMissingValue(found, 1000);
    (*returnSize)++;

    dfs(root->left, result, returnSize);
    dfs(root->right, result, returnSize);
}

int* smallestMissingGeneticValue(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    int** result = (int**)malloc(1000 * sizeof(int*));
    for (int i = 0; i < 1000; i++) {
        result[i] = (int*)malloc(1 * sizeof(int));
    }

    dfs(root, result, returnSize);

    int* finalResult = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        finalResult[i] = result[i][0];
        free(result[i]);
    }
    free(result);

    return finalResult;
}