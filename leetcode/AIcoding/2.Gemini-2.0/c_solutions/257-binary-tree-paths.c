#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char ** binaryTreePaths(struct TreeNode* root, int* returnSize){
    char **result = NULL;
    *returnSize = 0;
    if (!root) return NULL;

    int path[1000];
    int pathLen = 0;

    void dfs(struct TreeNode* node, int path[], int pathLen) {
        path[pathLen++] = node->val;

        if (!node->left && !node->right) {
            (*returnSize)++;
            result = (char**)realloc(result, (*returnSize) * sizeof(char*));
            result[*returnSize - 1] = (char*)malloc(3000 * sizeof(char));
            memset(result[*returnSize - 1], 0, 3000 * sizeof(char));
            int offset = 0;
            for (int i = 0; i < pathLen; i++) {
                if (i > 0) {
                    offset += sprintf(result[*returnSize - 1] + offset, "->");
                }
                offset += sprintf(result[*returnSize - 1] + offset, "%d", path[i]);
            }
            result[*returnSize - 1][offset] = '\0';
            return;
        }

        if (node->left) {
            dfs(node->left, path, pathLen);
        }
        if (node->right) {
            dfs(node->right, path, pathLen);
        }
    }

    dfs(root, path, pathLen);
    return result;
}