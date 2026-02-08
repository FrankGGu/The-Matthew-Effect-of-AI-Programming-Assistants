class Solution {
public:
    int subtreeInversionSum(TreeNode* root) {
        int ans = 0;
        function<vector<int>(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return vector<int>();

            vector<int> left = dfs(node->left);
            vector<int> right = dfs(node->right);
            vector<int> merged;

            int i = 0, j = 0;
            while (i < left.size() && j < right.size()) {
                if (left[i] <= right[j]) {
                    merged.push_back(left[i++]);
                } else {
                    merged.push_back(right[j++]);
                }
            }
            while (i < left.size()) merged.push_back(left[i++]);
            while (j < right.size()) merged.push_back(right[j++]);

            int inversions = 0;
            vector<int> current;
            i = 0, j = 0;
            while (i < left.size() && j < right.size()) {
                if (left[i] <= right[j]) {
                    current.push_back(left[i]);
                    i++;
                } else {
                    inversions += left.size() - i;
                    current.push_back(right[j]);
                    j++;
                }
            }
            while (i < left.size()) current.push_back(left[i++]);
            while (j < right.size()) current.push_back(right[j++]);

            int node_inversions = 0;
            for (int x : merged) {
                if (x > node->val) node_inversions++;
            }

            ans += node_inversions + inversions;

            vector<int> result;
            i = 0, j = 0;
            while (i < current.size() && node->val >= current[i]) {
                result.push_back(current[i++]);
            }
            result.push_back(node->val);
            while (i < current.size()) {
                result.push_back(current[i++]);
            }
            return result;
        };

        dfs(root);
        return ans;
    }
};