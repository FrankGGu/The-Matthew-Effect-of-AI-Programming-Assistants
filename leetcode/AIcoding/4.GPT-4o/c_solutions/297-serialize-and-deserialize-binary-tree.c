#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char* serialize(struct TreeNode* root) {
    if (!root) return "#,";
    char* left = serialize(root->left);
    char* right = serialize(root->right);
    size_t len = snprintf(NULL, 0, "%d,", root->val);
    char* result = malloc(len + strlen(left) + strlen(right) + 1);
    sprintf(result, "%d,%s%s", root->val, left, right);
    free(left);
    free(right);
    return result;
}

struct TreeNode* deserialize(char** data) {
    if (**data == '#') {
        (*data) += 2;
        return NULL;
    }
    int val;
    sscanf(*data, "%d,", &val);
    while (**data != ',') (*data)++;
    (*data)++;
    struct TreeNode* node = malloc(sizeof(struct TreeNode));
    node->val = val;
    node->left = deserialize(data);
    node->right = deserialize(data);
    return node;
}

struct TreeNode* deserializeTree(char* data) {
    char* ptr = data;
    return deserialize(&ptr);
}