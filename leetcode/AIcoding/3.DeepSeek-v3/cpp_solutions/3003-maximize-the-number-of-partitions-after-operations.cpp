class Solution {
public:
    int maxPartitionsAfterOperations(string s, int k) {
        int n = s.size();
        vector<vector<unordered_map<int, int>>> dp(n, vector<unordered_map<int, int>>(2));

        function<int(int, int, int)> dfs = [&](int pos, int changed, int mask) {
            if (pos == n) {
                return 1;
            }
            if (dp[pos][changed].count(mask)) {
                return dp[pos][changed][mask];
            }

            int res = 0;
            int new_mask = mask | (1 << (s[pos] - 'a'));
            int cnt = __builtin_popcount(new_mask);

            if (cnt > k) {
                res = 1 + dfs(pos + 1, changed, 1 << (s[pos] - 'a'));
            } else {
                res = dfs(pos + 1, changed, new_mask);
            }

            if (!changed) {
                for (char c = 'a'; c <= 'z'; ++c) {
                    if (c == s[pos]) continue;
                    int temp_mask = mask | (1 << (c - 'a'));
                    int temp_cnt = __builtin_popcount(temp_mask);

                    if (temp_cnt > k) {
                        res = max(res, 1 + dfs(pos + 1, 1, 1 << (c - 'a')));
                    } else {
                        res = max(res, dfs(pos + 1, 1, temp_mask));
                    }
                }
            }

            return dp[pos][changed][mask] = res;
        };

        return dfs(0, 0, 0);
    }
};