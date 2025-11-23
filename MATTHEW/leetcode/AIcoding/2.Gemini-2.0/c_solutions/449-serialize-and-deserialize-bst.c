#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* serialize(struct TreeNode* root) {
    char* str = (char*)malloc(10000 * sizeof(char));
    str[0] = '\0';

    if (!root) {
        strcat(str, "null,");
        return str;
    }

    char valStr[20];
    sprintf(valStr, "%d,", root->val);
    strcat(str, valStr);

    char* leftStr = serialize(root->left);
    strcat(str, leftStr);
    free(leftStr);

    char* rightStr = serialize(root->right);
    strcat(str, rightStr);
    free(rightStr);

    return str;
}

struct TreeNode* deserializeHelper(char** data) {
    if (!data || !*data) return NULL;

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
    root->left = deserializeHelper(data);
    root->right = deserializeHelper(data);
    return root;
}

struct TreeNode* deserialize(char* data) {
    return deserializeHelper(&data);
}