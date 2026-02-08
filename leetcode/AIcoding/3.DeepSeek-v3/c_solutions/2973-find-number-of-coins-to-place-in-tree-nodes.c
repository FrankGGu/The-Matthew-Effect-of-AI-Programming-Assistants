/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

typedef struct {
    long long sum;
    int count;
} SubtreeInfo;

long long max(long long a, long long b) {
    return a > b ? a : b;
}

SubtreeInfo dfs(struct TreeNode* node, long long* maxScore) {
    if (!node) {
        return (SubtreeInfo){0, 0};
    }

    SubtreeInfo left = dfs(node->left, maxScore);
    SubtreeInfo right = dfs(node->right, maxScore);

    long long totalSum = left.sum + right.sum + node->val;
    int totalCount = left.count + right.count + 1;

    if (totalCount > 1) {
        long long product = (long long)(totalSum - node->val) * node->val;
        *maxScore = max(*maxScore, product);
    }

    return (SubtreeInfo){totalSum, totalCount};
}

long long placedCoins(struct TreeNode** root, int rootSize) {
    long long maxScore = 0;
    dfs(*root, &maxScore);
    return maxScore > 0 ? maxScore : 0;
}