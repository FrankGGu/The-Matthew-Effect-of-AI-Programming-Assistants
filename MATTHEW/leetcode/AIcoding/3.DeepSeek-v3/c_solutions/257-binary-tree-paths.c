#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void dfs(struct TreeNode* root, char* path, int path_len, char** result, int* returnSize) {
    if (!root) return;

    int len = 0;
    char num[12];
    sprintf(num, "%d", root->val);
    len = strlen(num);

    if (path_len > 0) {
        path[path_len++] = '-';
        path[path_len++] = '>';
        len += 2;
    }

    strcpy(path + path_len, num);
    path_len += strlen(num);

    if (!root->left && !root->right) {
        path[path_len] = '\0';
        result[*returnSize] = (char*)malloc(path_len + 1);
        strcpy(result[*returnSize], path);
        (*returnSize)++;
        return;
    }

    if (root->left) {
        dfs(root->left, path, path_len, result, returnSize);
    }

    if (root->right) {
        dfs(root->right, path, path_len, result, returnSize);
    }
}

char** binaryTreePaths(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    if (!root) return NULL;

    char** result = (char**)malloc(100 * sizeof(char*));
    char* path = (char*)malloc(1000 * sizeof(char));

    dfs(root, path, 0, result, returnSize);

    free(path);
    return result;
}