class Solution {
public:
    int maxSumBST(TreeNode* root) {
        int maxSum = 0;
        function<vector<int>(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) {
                return vector<int>{1, INT_MAX, INT_MIN, 0};
            }

            vector<int> left = dfs(node->left);
            vector<int> right = dfs(node->right);

            if (left[0] && right[0] && node->val > left[2] && node->val < right[1]) {
                int sum = left[3] + right[3] + node->val;
                maxSum = max(maxSum, sum);
                return vector<int>{1, min(node->val, left[1]), max(node->val, right[2]), sum};
            } else {
                return vector<int>{0, 0, 0, 0};
            }
        };

        dfs(root);
        return maxSum;
    }
};