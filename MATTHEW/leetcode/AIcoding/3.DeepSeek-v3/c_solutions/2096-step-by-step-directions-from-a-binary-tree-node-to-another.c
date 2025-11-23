/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

bool findPath(struct TreeNode* root, int target, char* path, int* index) {
    if (root == NULL) return false;

    if (root->val == target) return true;

    path[(*index)++] = 'L';
    if (findPath(root->left, target, path, index)) return true;
    (*index)--;

    path[(*index)++] = 'R';
    if (findPath(root->right, target, path, index)) return true;
    (*index)--;

    return false;
}

char* getDirections(struct TreeNode* root, int startValue, int destValue) {
    char* startPath = (char*)malloc(100000 * sizeof(char));
    char* destPath = (char*)malloc(100000 * sizeof(char));
    int startIndex = 0, destIndex = 0;

    findPath(root, startValue, startPath, &startIndex);
    findPath(root, destValue, destPath, &destIndex);

    startPath[startIndex] = '\0';
    destPath[destIndex] = '\0';

    int i = 0;
    while (i < startIndex && i < destIndex && startPath[i] == destPath[i]) {
        i++;
    }

    char* result = (char*)malloc((startIndex + destIndex - 2 * i + 1) * sizeof(char));
    int resultIndex = 0;

    for (int j = i; j < startIndex; j++) {
        result[resultIndex++] = 'U';
    }

    for (int j = i; j < destIndex; j++) {
        result[resultIndex++] = destPath[j];
    }

    result[resultIndex] = '\0';

    free(startPath);
    free(destPath);

    return result;
}