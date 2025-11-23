#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int countPairs(struct TreeNode* root, int distance) {
    int result = 0;

    int* leaves = (int*)malloc(0);
    int leavesSize = 0;

    void dfs(struct TreeNode* node, int depth, int* path) {
        if (!node) return;
        if (!node->left && !node->right) {
            int* newLeaves = (int*)realloc(leaves, (leavesSize + 1) * sizeof(int));
            if (newLeaves) {
                leaves = newLeaves;
                leaves[leavesSize++] = depth;
            }
            return;
        }
        int* newPath = (int*)malloc((depth + 1) * sizeof(int));
        for (int i = 0; i < depth; i++) newPath[i] = path[i];
        newPath[depth] = 0;
        dfs(node->left, depth + 1, newPath);
        newPath[depth] = 1;
        dfs(node->right, depth + 1, newPath);
        free(newPath);
    }

    dfs(root, 0, NULL);

    for (int i = 0; i < leavesSize; i++) {
        for (int j = i + 1; j < leavesSize; j++) {
            int a = leaves[i], b = leaves[j];
            int lca = 0;
            while (a != b) {
                if (a > b) a /= 2;
                else b /= 2;
                lca++;
            }
            if (lca * 2 <= distance) result++;
        }
    }

    free(leaves);
    return result;
}