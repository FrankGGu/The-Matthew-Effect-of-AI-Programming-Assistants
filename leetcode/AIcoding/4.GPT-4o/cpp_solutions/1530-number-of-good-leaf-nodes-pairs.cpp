class Solution {
public:
    int countPairs(TreeNode* root, int distance) {
        int count = 0;
        function<vector<int>(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return vector<int>();
            if (!node->left && !node->right) return vector<int>(1, 1);
            vector<int> left = dfs(node->left);
            vector<int> right = dfs(node->right);
            for (int l : left) {
                for (int r : right) {
                    if (l + r <= distance) count++;
                }
            }
            left.insert(left.end(), right.begin(), right.end());
            for (int& l : left) l++;
            return left;
        };
        dfs(root);
        return count;
    }
};