#include <stdlib.h>
#include <string.h>
#include <stdio.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char* serialize(struct TreeNode* root) {
    if (!root) return "#";
    char* left = serialize(root->left);
    char* right = serialize(root->right);
    int len = strlen(left) + strlen(right) + 20;
    char* result = (char*)malloc(len);
    sprintf(result, "%d,%s,%s", root->val, left, right);
    return result;
}

struct TreeNode* deserialize(char** data) {
    if (**data == '#') {
        (*data)++;
        return NULL;
    }
    int val = 0;
    while (**data != ',') {
        val = val * 10 + (**data - '0');
        (*data)++;
    }
    (*data)++;
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = val;
    root->left = deserialize(data);
    root->right = deserialize(data);
    return root;
}

struct TreeNode* deserializeString(char* data) {
    return deserialize(&data);
}