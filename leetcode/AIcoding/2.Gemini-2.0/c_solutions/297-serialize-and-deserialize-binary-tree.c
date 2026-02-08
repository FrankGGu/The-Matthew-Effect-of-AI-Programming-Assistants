#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

char* serialize(TreeNode* root) {
    if (!root) {
        return strdup("null");
    }

    char* leftSerialized = serialize(root->left);
    char* rightSerialized = serialize(root->right);

    char buffer[100];
    sprintf(buffer, "%d,", root->val);

    char* result = (char*)malloc(strlen(buffer) + strlen(leftSerialized) + strlen(rightSerialized) + 3);
    strcpy(result, buffer);
    strcat(result, leftSerialized);
    strcat(result, ",");
    strcat(result, rightSerialized);

    free(leftSerialized);
    free(rightSerialized);

    return result;
}

TreeNode* deserializeHelper(char** data) {
    char* token = strsep(data, ",");
    if (strcmp(token, "null") == 0) {
        return NULL;
    }

    TreeNode* root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = atoi(token);
    root->left = deserializeHelper(data);
    root->right = deserializeHelper(data);

    return root;
}

TreeNode* deserialize(char* data) {
    return deserializeHelper(&data);
}