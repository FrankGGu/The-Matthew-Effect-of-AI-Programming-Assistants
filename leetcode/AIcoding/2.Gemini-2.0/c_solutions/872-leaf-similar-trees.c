#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void getLeafSequence(struct TreeNode* root, int* leaves, int* count) {
    if (root == NULL) {
        return;
    }
    if (root->left == NULL && root->right == NULL) {
        leaves[*count] = root->val;
        (*count)++;
        return;
    }
    getLeafSequence(root->left, leaves, count);
    getLeafSequence(root->right, leaves, count);
}

bool leafSimilar(struct TreeNode* root1, struct TreeNode* root2) {
    int leaves1[200] = {0};
    int leaves2[200] = {0};
    int count1 = 0;
    int count2 = 0;

    getLeafSequence(root1, leaves1, &count1);
    getLeafSequence(root2, leaves2, &count2);

    if (count1 != count2) {
        return false;
    }

    for (int i = 0; i < count1; i++) {
        if (leaves1[i] != leaves2[i]) {
            return false;
        }
    }

    return true;
}