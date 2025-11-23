#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

char* serialize(struct TreeNode* root) {
    if (!root) {
        return strdup("null,");
    }
    char* left = serialize(root->left);
    char* right = serialize(root->right);

    char val_str[20];
    sprintf(val_str, "%d,", root->val);

    int len = strlen(val_str) + strlen(left) + strlen(right) + 1;
    char* result = (char*)malloc(len * sizeof(char));
    strcpy(result, val_str);
    strcat(result, left);
    strcat(result, right);

    free(left);
    free(right);

    return result;
}

struct TreeNode* deserialize_helper(char** data) {
    if (!*data) return NULL;

    if (strncmp(*data, "null", 4) == 0) {
        *data += 5;
        return NULL;
    }

    int val = 0;
    int sign = 1;
    if (**data == '-') {
        sign = -1;
        (*data)++;
    }

    while (**data >= '0' && **data <= '9') {
        val = val * 10 + (**data - '0');
        (*data)++;
    }
    val *= sign;

    (*data)++; 

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = val;
    root->left = deserialize_helper(data);
    root->right = deserialize_helper(data);

    return root;
}

struct TreeNode* deserialize(char* data) {
    return deserialize_helper(&data);
}