#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAX_STRING_LENGTH 100000

char* tree2str(struct TreeNode* root) {
    if (root == NULL) {
        char* s = (char*)malloc(1);
        s[0] = '\0';
        return s;
    }

    char* left_str = tree2str(root->left);
    char* right_str = tree2str(root->right);

    char* result_str = (char*)malloc(MAX_STRING_LENGTH * sizeof(char));

    if (root->left == NULL && root->right == NULL) {
        sprintf(result_str, "%d", root->val);
    } else if (root->right == NULL) { // Has left child, but no right child
        sprintf(result_str, "%d(%s)", root->val, left_str);
    } else { // Has right child (left child might be null or not)
        sprintf(result_str, "%d(%s)(%s)", root->val, left_str, right_str);
    }

    free(left_str);
    free(right_str);

    return result_str;
}