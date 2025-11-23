class Solution {
public:
    int countNodesEqualToAverage(TreeNode* root) {
        int count = 0;
        function<pair<int, int>(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return make_pair(0, 0);
            auto left = dfs(node->left);
            auto right = dfs(node->right);
            int sum = left.first + right.first + node->val;
            int size = left.second + right.second + 1;
            if (node->val == sum / size) count++;
            return make_pair(sum, size);
        };
        dfs(root);
        return count;
    }
};