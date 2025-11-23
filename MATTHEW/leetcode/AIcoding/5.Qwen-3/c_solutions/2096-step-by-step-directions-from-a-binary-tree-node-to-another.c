#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

char* getDirections(struct TreeNode* root, int startValue, int endValue) {
    char* pathToStart = (char*)malloc(1000 * sizeof(char));
    char* pathToEnd = (char*)malloc(1000 * sizeof(char));
    char* result = (char*)malloc(1000 * sizeof(char));

    int foundStart = 0;
    int foundEnd = 0;

    void findPath(struct TreeNode* node, int target, char* path, int* found, char** result) {
        if (!node) return;
        if (node->val == target) {
            *found = 1;
            strcpy(*result, path);
            return;
        }
        char temp[1000];
        strcpy(temp, path);
        strcat(temp, "L");
        findPath(node->left, target, temp, found, result);
        if (*found) return;
        strcpy(temp, path);
        strcat(temp, "R");
        findPath(node->right, target, temp, found, result);
        if (*found) return;
    }

    findPath(root, startValue, "", &foundStart, &pathToStart);
    findPath(root, endValue, "", &foundEnd, &pathToEnd);

    int i = 0;
    while (pathToStart[i] && pathToEnd[i] && pathToStart[i] == pathToEnd[i]) {
        i++;
    }

    int lenStart = strlen(pathToStart) - i;
    int lenEnd = strlen(pathToEnd) - i;

    for (int j = 0; j < lenStart; j++) {
        result[j] = 'U';
    }
    for (int j = 0; j < lenEnd; j++) {
        result[lenStart + j] = pathToEnd[i + j];
    }
    result[lenStart + lenEnd] = '\0';

    free(pathToStart);
    free(pathToEnd);

    return result;
}