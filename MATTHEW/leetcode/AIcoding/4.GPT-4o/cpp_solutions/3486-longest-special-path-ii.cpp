class Solution {
public:
    int longestPath(vector<int>& parent, string s) {
        int n = parent.size();
        vector<vector<int>> tree(n);
        for (int i = 1; i < n; ++i) {
            tree[parent[i]].push_back(i);
        }
        int result = 1;
        dfs(0, tree, s, result);
        return result;
    }

private:
    int dfs(int node, vector<vector<int>>& tree, string& s, int& result) {
        int max1 = 0, max2 = 0;
        for (int child : tree[node]) {
            int length = dfs(child, tree, s, result);
            if (s[child] != s[node]) {
                if (length > max1) {
                    max2 = max1;
                    max1 = length;
                } else if (length > max2) {
                    max2 = length;
                }
            }
        }
        result = max(result, max1 + max2 + 1);
        return max1 + 1;
    }
};