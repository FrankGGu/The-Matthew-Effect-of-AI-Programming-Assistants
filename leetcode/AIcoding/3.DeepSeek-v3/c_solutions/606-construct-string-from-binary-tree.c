#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void helper(struct TreeNode* t, char* str, int* pos) {
    if (t == NULL) return;

    int n = sprintf(str + *pos, "%d", t->val);
    *pos += n;

    if (t->left == NULL && t->right == NULL) return;

    str[(*pos)++] = '(';
    helper(t->left, str, pos);
    str[(*pos)++] = ')';

    if (t->right) {
        str[(*pos)++] = '(';
        helper(t->right, str, pos);
        str[(*pos)++] = ')';
    }
}

char* tree2str(struct TreeNode* t) {
    if (t == NULL) return "";

    char* str = (char*)malloc(100000 * sizeof(char));
    int pos = 0;
    helper(t, str, &pos);
    str[pos] = '\0';
    return str;
}