class Solution {
public:
    int countPairs(TreeNode* root, int distance) {
        int res = 0;
        dfs(root, distance, res);
        return res;
    }

    vector<int> dfs(TreeNode* node, int distance, int& res) {
        if (!node) return {};
        if (!node->left && !node->right) return {1};

        auto left = dfs(node->left, distance, res);
        auto right = dfs(node->right, distance, res);

        for (auto l : left) {
            for (auto r : right) {
                if (l + r <= distance) res++;
            }
        }

        vector<int> ret;
        for (auto l : left) {
            if (l + 1 < distance) ret.push_back(l + 1);
        }
        for (auto r : right) {
            if (r + 1 < distance) ret.push_back(r + 1);
        }
        return ret;
    }
};