#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
  int val;
  struct TreeNode *left;
  struct TreeNode *right;
};

void tree2strHelper(struct TreeNode* t, char* str, int* index) {
    if (!t) return;

    int num = t->val;
    char numStr[12];
    sprintf(numStr, "%d", num);
    for (int i = 0; numStr[i] != '\0'; i++) {
        str[(*index)++] = numStr[i];
    }

    if (!t->left && !t->right) return;

    str[(*index)++] = '(';
    tree2strHelper(t->left, str, index);
    str[(*index)++] = ')';

    if (t->right) {
        str[(*index)++] = '(';
        tree2strHelper(t->right, str, index);
        str[(*index)++] = ')';
    }
}

char* tree2str(struct TreeNode* t) {
    char* str = (char*)malloc(sizeof(char) * 10001);
    int index = 0;
    tree2strHelper(t, str, &index);
    str[index] = '\0';
    return str;
}