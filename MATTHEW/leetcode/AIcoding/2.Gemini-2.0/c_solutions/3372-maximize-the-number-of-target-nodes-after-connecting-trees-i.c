#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int dfs(struct TreeNode* root, bool* targetValues, int* count) {
    if (!root) return 0;

    int left = dfs(root->left, targetValues, count);
    int right = dfs(root->right, targetValues, count);

    if (targetValues[root->val]) {
        if (left == 0 || right == 0) {
            *count += 1;
            return 1;
        } else {
            return 0;
        }
    } else {
        return left + right;
    }
}

int solve(int n, struct TreeNode** trees, int treesSize, int* target, int targetSize) {
    bool* targetValues = (bool*)calloc(n + 1, sizeof(bool));
    for (int i = 0; i < targetSize; i++) {
        targetValues[target[i]] = true;
    }

    int count = 0;
    bool* visited = (bool*)calloc(treesSize, sizeof(bool));
    for (int i = 0; i < treesSize; i++) {
        if (trees[i] && !visited[i] && targetValues[trees[i]->val]) {
            int tempCount = 0;
            dfs(trees[i], targetValues, &tempCount);
            count += tempCount;
        }
    }

    free(targetValues);
    free(visited);

    return count;
}