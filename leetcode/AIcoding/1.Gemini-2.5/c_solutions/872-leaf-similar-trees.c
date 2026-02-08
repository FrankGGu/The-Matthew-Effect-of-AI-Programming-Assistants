#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void collectLeaves(struct TreeNode* root, int* leaves, int* count) {
    if (root == NULL) {
        return;
    }

    if (root->left == NULL && root->right == NULL) {
        leaves[*count] = root->val;
        (*count)++;
        return;
    }

    collectLeaves(root->left, leaves, count);
    collectLeaves(root->right, leaves, count);
}

bool isLeafSimilar(struct TreeNode* root1, struct TreeNode* root2) {
    int leaves1[1001];
    int count1 = 0;
    collectLeaves(root1, leaves1, &count1);

    int leaves2[1001];
    int count2 = 0;
    collectLeaves(root2, leaves2, &count2);

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