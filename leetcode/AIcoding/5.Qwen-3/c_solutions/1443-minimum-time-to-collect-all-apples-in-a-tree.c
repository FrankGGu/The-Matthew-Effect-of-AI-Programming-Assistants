#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int minTimeToCollectAllApples(int* hasApple, int hasAppleSize, TreeNode* root) {
    if (!root) return 0;

    int leftTime = minTimeToCollectAllApples(hasApple, hasAppleSize, root->left);
    int rightTime = minTimeToCollectAllApples(hasApple, hasAppleSize, root->right);

    int total = leftTime + rightTime;

    if (total > 0 || hasApple[root->val]) {
        return total + 2;
    }

    return 0;
}