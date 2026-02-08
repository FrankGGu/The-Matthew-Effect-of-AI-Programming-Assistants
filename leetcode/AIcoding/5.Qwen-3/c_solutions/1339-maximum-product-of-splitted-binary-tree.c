#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int maxProduct(struct TreeNode* root) {
    long total = 0;
    long maxProd = 0;

    void dfs(struct TreeNode* node) {
        if (!node) return;
        total += node->val;
        dfs(node->left);
        dfs(node->right);
    }

    dfs(root);

    long dfs2(struct TreeNode* node) {
        if (!node) return 0;
        long left = dfs2(node->left);
        long right = dfs2(node->right);
        long sum = node->val + left + right;
        maxProd = (maxProd > (total - sum) * sum) ? maxProd : (total - sum) * sum;
        return sum;
    }

    dfs2(root);
    return (int)(maxProd % (1000000007));
}