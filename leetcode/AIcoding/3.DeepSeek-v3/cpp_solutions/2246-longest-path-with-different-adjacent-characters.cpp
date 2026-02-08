class Solution {
public:
    int longestPath(vector<int>& parent, string s) {
        int n = parent.size();
        vector<vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parent[i]].push_back(i);
        }
        int res = 1;
        dfs(0, children, s, res);
        return res;
    }

    int dfs(int node, vector<vector<int>>& children, string& s, int& res) {
        int max1 = 0, max2 = 0;
        for (int child : children[node]) {
            int len = dfs(child, children, s, res);
            if (s[child] == s[node]) continue;
            if (len > max1) {
                max2 = max1;
                max1 = len;
            } else if (len > max2) {
                max2 = len;
            }
        }
        res = max(res, max1 + max2 + 1);
        return max1 + 1;
    }
};