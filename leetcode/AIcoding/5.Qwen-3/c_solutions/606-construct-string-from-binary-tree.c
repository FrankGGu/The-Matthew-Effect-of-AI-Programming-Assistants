#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

char* tree2str(struct TreeNode* root) {
    if (!root) return "";

    int len = 1; // for the value
    if (root->left || root->right) len += 2; // for parentheses

    if (root->left) {
        len += strlen(tree2str(root->left));
    }
    if (root->right) {
        len += strlen(tree2str(root->right));
    }

    char* result = (char*)malloc(len * sizeof(char));
    sprintf(result, "%d", root->val);

    if (root->left || root->right) {
        strcat(result, "(");
        if (root->left) {
            strcat(result, tree2str(root->left));
        }
        strcat(result, ")");
        if (root->right) {
            strcat(result, "(");
            strcat(result, tree2str(root->right));
            strcat(result, ")");
        }
    }

    return result;
}