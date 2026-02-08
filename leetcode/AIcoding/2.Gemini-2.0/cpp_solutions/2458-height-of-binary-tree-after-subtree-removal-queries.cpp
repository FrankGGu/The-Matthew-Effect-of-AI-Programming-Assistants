#include <vector>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    vector<int> treeQueries(TreeNode* root, vector<int>& queries) {
        vector<int> depth(50001, -1);
        vector<int> height(50001, -1);
        vector<TreeNode*> nodes(50001, nullptr);

        function<void(TreeNode*, int)> dfs_depth = [&](TreeNode* node, int d) {
            if (!node) return;
            depth[node->val] = d;
            nodes[node->val] = node;
            dfs_depth(node->left, d + 1);
            dfs_depth(node->right, d + 1);
        };

        dfs_depth(root, 0);

        function<int(TreeNode*)> dfs_height = [&](TreeNode* node) {
            if (!node) return -1;
            if (height[node->val] != -1) return height[node->val];

            height[node->val] = 1 + max(dfs_height(node->left), dfs_height(node->right));
            return height[node->val];
        };

        dfs_height(root);

        int n = queries.size();
        vector<int> result(n);

        for (int i = 0; i < n; ++i) {
            int target = queries[i];
            int d = depth[target];

            function<int(TreeNode*, int, int)> solve = [&](TreeNode* node, int current_depth, int removed_depth) {
                if (!node) return -1;
                if (node->val == target) return -1;

                int left_height = solve(node->left, current_depth + 1, removed_depth);
                int right_height = solve(node->right, current_depth + 1, removed_depth);

                return 1 + max(left_height, right_height);
            };

            vector<int> heights;

            function<void(TreeNode*, int)> collect_heights = [&](TreeNode* node, int current_depth) {
                if (!node) return;

                int left_height = height[node->val] - (current_depth - d) - (node->left && nodes[target] == node->left ? height[node->left->val] + 1 : 0);
                int right_height = height[node->val] - (current_depth - d) - (node->right && nodes[target] == node->right ? height[node->right->val] + 1 : 0);

                if (node->left && nodes[target] != node->left) collect_heights(node->left, current_depth + 1);
                if (node->right && nodes[target] != node->right) collect_heights(node->right, current_depth + 1);

                heights.push_back(max(left_height, right_height));
            };

            collect_heights(root, 0);

            result[i] = heights.empty() ? 0 : *max_element(heights.begin(), heights.end());
        }

        return result;
    }
};