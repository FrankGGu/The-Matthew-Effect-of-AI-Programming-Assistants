class Solution {
public:
    int countPairs(TreeNode* root, int distance) {
        int count = 0;
        function<vector<int>(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return vector<int>();
            if (!node->left && !node->right) return vector<int>{1};

            vector<int> leftDistances = dfs(node->left);
            vector<int> rightDistances = dfs(node->right);

            for (int l : leftDistances) {
                for (int r : rightDistances) {
                    if (l + r <= distance) {
                        count++;
                    }
                }
            }

            vector<int> distances;
            for (int l : leftDistances) {
                if (l + 1 <= distance) {
                    distances.push_back(l + 1);
                }
            }
            for (int r : rightDistances) {
                if (r + 1 <= distance) {
                    distances.push_back(r + 1);
                }
            }

            return distances;
        };

        dfs(root);
        return count;
    }
};