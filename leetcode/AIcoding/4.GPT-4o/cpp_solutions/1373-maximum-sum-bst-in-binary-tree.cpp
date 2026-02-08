class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int maxSum = 0;

    tuple<int, int, bool> dfs(TreeNode* node) {
        if (!node) return {0, 0, true};

        auto [leftSum, leftMax, isLeftBST] = dfs(node->left);
        auto [rightSum, rightMax, isRightBST] = dfs(node->right);

        if (isLeftBST && isRightBST && node->val > leftMax && node->val < rightMax) {
            int currentSum = leftSum + rightSum + node->val;
            maxSum = max(maxSum, currentSum);
            return {currentSum, max(node->val, rightMax), true};
        }

        return {0, 0, false};
    }

    int maxSumBST(TreeNode* root) {
        dfs(root);
        return maxSum;
    }
};