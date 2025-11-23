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
    int len = snprintf(NULL, 0, "%d,%s,%s", root->val, left, right);
    char* result = malloc(len + 1);
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
    int val = 0;
    while (**data != ',' && **data != '\0') {
        val = val * 10 + (**data - '0');
        (*data)++;
    }
    (*data)++;
    struct TreeNode* root = malloc(sizeof(struct TreeNode));
    root->val = val;
    root->left = deserialize(data);
    root->right = deserialize(data);
    return root;
}

struct TreeNode* deserialize_helper(char* data) {
    return deserialize(&data);
}