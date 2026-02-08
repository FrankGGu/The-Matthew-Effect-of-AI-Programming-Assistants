#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char* serialize(struct TreeNode* root) {
    if (!root) return "#";
    char* left = serialize(root->left);
    char* right = serialize(root->right);
    char* result = (char*)malloc(strlen(left) + strlen(right) + 20);
    sprintf(result, "%d,%s,%s", root->val, left, right);
    free(left);
    free(right);
    return result;
}

struct TreeNode* deserialize(char** data) {
    if (**data == '#') {
        (*data)++;
        return NULL;
    }
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    sscanf(*data, "%d", &node->val);
    while (**data != ',' && **data != '\0') (*data)++;
    (*data)++;
    node->left = deserialize(data);
    node->right = deserialize(data);
    return node;
}

struct TreeNode* deserializeTree(char* data) {
    char* ptr = data;
    return deserialize(&ptr);
}