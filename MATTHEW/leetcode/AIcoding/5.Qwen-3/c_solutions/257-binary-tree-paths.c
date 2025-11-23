#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

char** binaryTreePaths(struct TreeNode* root, int* returnSize) {
    char** result = NULL;
    *returnSize = 0;

    if (!root) return result;

    char path[1024];
    int pathLen = 0;

    void dfs(struct TreeNode* node) {
        if (!node) return;

        int len = strlen(path);
        sprintf(path + len, "%d", node->val);
        pathLen = strlen(path);

        if (!node->left && !node->right) {
            char* str = (char*)malloc((pathLen + 1) * sizeof(char));
            strcpy(str, path);
            result = (char**)realloc(result, (*returnSize + 1) * sizeof(char*));
            result[*returnSize] = str;
            (*returnSize)++;
        }

        if (node->left) {
            dfs(node->left);
        }
        if (node->right) {
            dfs(node->right);
        }

        path[pathLen - 1] = '\0';
    }

    dfs(root);
    return result;
}