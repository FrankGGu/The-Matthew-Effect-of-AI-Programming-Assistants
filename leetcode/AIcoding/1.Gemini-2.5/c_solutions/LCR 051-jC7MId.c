#include <limits.h> // Required for INT_MIN

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

static int global_max_sum;

static int max(int a, int b) {
    return a > b ? a : b;
}

static int maxPathSumHelper(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }

    int left_gain = max(0, maxPathSumHelper(root->left));
    int right_gain = max(0, maxPathSumHelper(root->right));

    global_max_sum = max(global_max_sum, root->val + left_gain + right_gain);

    return root->val + max(left_gain, right_gain);
}

int maxPathSum(struct TreeNode* root) {
    global_max_sum = INT_MIN;
    maxPathSumHelper(root);
    return global_max_sum;
}