class Solution {
public:
    vector<int> treeQueries(TreeNode* root, vector<int>& queries) {
        unordered_map<int, int> depth, height;
        unordered_map<int, vector<int>> depth_nodes;
        int max_depth = 0;

        function<void(TreeNode*, int)> dfs = [&](TreeNode* node, int d) {
            if (!node) return;
            depth[node->val] = d;
            depth_nodes[d].push_back(node->val);
            max_depth = max(max_depth, d);

            dfs(node->left, d + 1);
            dfs(node->right, d + 1);

            int h = 0;
            if (node->left) h = max(h, height[node->left->val] + 1);
            if (node->right) h = max(h, height[node->right->val] + 1);
            height[node->val] = h;
        };

        dfs(root, 0);

        vector<vector<int>> prefix(max_depth + 1), suffix(max_depth + 1);
        for (int d = 0; d <= max_depth; ++d) {
            auto& nodes = depth_nodes[d];
            int n = nodes.size();
            prefix[d].resize(n);
            suffix[d].resize(n);
            for (int i = 0; i < n; ++i) {
                prefix[d][i] = height[nodes[i]];
                if (i > 0) prefix[d][i] = max(prefix[d][i], prefix[d][i - 1]);
            }
            for (int i = n - 1; i >= 0; --i) {
                suffix[d][i] = height[nodes[i]];
                if (i < n - 1) suffix[d][i] = max(suffix[d][i], suffix[d][i + 1]);
            }
        }

        vector<int> res;
        for (int q : queries) {
            int d = depth[q];
            auto& nodes = depth_nodes[d];
            int n = nodes.size();
            int pos = -1;
            for (int i = 0; i < n; ++i) {
                if (nodes[i] == q) {
                    pos = i;
                    break;
                }
            }
            int max_h = 0;
            if (pos > 0) max_h = max(max_h, prefix[d][pos - 1]);
            if (pos < n - 1) max_h = max(max_h, suffix[d][pos + 1]);
            res.push_back(d + max_h);
        }
        return res;
    }
};