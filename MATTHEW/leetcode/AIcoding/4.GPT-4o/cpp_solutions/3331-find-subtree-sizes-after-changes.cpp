class Solution {
public:
    vector<int> findSubtreeSizes(TreeNode* root, vector<vector<int>>& queries) {
        unordered_map<int, int> sizeMap;
        vector<int> results;
        int index = 0;

        function<int(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return 0;
            int size = 1 + dfs(node->left) + dfs(node->right);
            sizeMap[node->val] = size;
            return size;
        };

        dfs(root);

        for (const auto& query : queries) {
            results.push_back(sizeMap[query[0]]);
        }

        return results;
    }
};