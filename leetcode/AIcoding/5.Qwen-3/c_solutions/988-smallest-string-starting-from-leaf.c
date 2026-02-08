#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char* smallestFromLeaf(struct TreeNode* root) {
    char* result = (char*)malloc(26 * sizeof(char));
    result[0] = '\0';

    void dfs(struct TreeNode* node, char* path, int len) {
        if (!node) return;

        path[len] = 'a' + node->val;
        len++;

        if (!node->left && !node->right) {
            path[len] = '\0';
            int cmp = strcmp(result, path);
            if (cmp > 0 || result[0] == '\0') {
                strcpy(result, path);
            }
            return;
        }

        dfs(node->left, path, len);
        dfs(node->right, path, len);
    }

    char* path = (char*)malloc(26 * sizeof(char));
    dfs(root, path, 0);
    free(path);
    return result;
}