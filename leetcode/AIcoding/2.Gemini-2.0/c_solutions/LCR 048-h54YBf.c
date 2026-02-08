#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* serialize(struct TreeNode* root) {
    if (!root) {
        char* str = (char*)malloc(sizeof(char) * 2);
        strcpy(str, "N,");
        return str;
    }

    char* leftStr = serialize(root->left);
    char* rightStr = serialize(root->right);

    char numStr[12];
    sprintf(numStr, "%d,", root->val);

    int len = strlen(numStr) + strlen(leftStr) + strlen(rightStr) + 1;
    char* result = (char*)malloc(sizeof(char) * len);

    strcpy(result, numStr);
    strcat(result, leftStr);
    strcat(result, rightStr);

    free(leftStr);
    free(rightStr);

    return result;
}

struct TreeNode* deserializeHelper(char** data) {
    if (!*data) {
        return NULL;
    }

    if (strncmp(*data, "N,", 2) == 0) {
        *data += 2;
        return NULL;
    }

    int val = 0;
    int sign = 1;
    if (**data == '-') {
        sign = -1;
        (*data)++;
    }

    while (**data != ',') {
        val = val * 10 + (**data - '0');
        (*data)++;
    }
    val *= sign;

    (*data)++;

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = val;
    root->left = deserializeHelper(data);
    root->right = deserializeHelper(data);

    return root;
}

struct TreeNode* deserialize(char* data) {
    return deserializeHelper(&data);
}