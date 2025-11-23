#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int rob;
    int not_rob;
} Result;

Result dfs(struct TreeNode* root) {
    if (root == NULL) {
        return (Result){0, 0};
    }

    Result left = dfs(root->left);
    Result right = dfs(root->right);

    int rob = root->val + left.not_rob + right.not_rob;
    int not_rob = (left.rob > left.not_rob ? left.rob : left.not_rob) + 
                  (right.rob > right.not_rob ? right.rob : right.not_rob);

    return (Result){rob, not_rob};
}

int rob(struct TreeNode* root) {
    Result result = dfs(root);
    return result.rob > result.not_rob ? result.rob : result.not_rob;
}