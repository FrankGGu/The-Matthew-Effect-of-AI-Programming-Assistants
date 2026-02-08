void constructPaths(struct TreeNode* root, char* path, int pathLen, char*** result, int* returnSize) {
    if (root == NULL) return;

    int len = sprintf(path + pathLen, "%d", root->val);
    pathLen += len;

    if (root->left == NULL && root->right == NULL) {
        path[pathLen] = '\0';
        (*result)[(*returnSize)++] = strdup(path);
    } else {
        path[pathLen] = '>';
        constructPaths(root->left, path, pathLen + 1, result, returnSize);
        constructPaths(root->right, path, pathLen + 1, result, returnSize);
    }
}

char** binaryTreePaths(struct TreeNode* root, int* returnSize) {
    char** result = (char**)malloc(1000 * sizeof(char*));
    *returnSize = 0;
    char path[1000];
    constructPaths(root, path, 0, &result, returnSize);
    return result;
}