class Solution {
public:
    long long countPalindromePaths(vector<int>& parent, string s) {
        int n = parent.size();
        vector<vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parent[i]].push_back(i);
        }

        unordered_map<int, int> freq;
        freq[0] = 1;
        long long res = 0;

        function<void(int, int)> dfs = [&](int u, int mask) {
            for (int v : children[u]) {
                int new_mask = mask ^ (1 << (s[v] - 'a'));
                res += freq[new_mask];
                for (int i = 0; i < 26; ++i) {
                    res += freq[new_mask ^ (1 << i)];
                }
                freq[new_mask]++;
                dfs(v, new_mask);
            }
        };

        dfs(0, 0);
        return res;
    }
};