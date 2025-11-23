class Solution {
public:
    int countGoodIntegers(long long num) {
        string s = to_string(num);
        int n = s.size();
        long long res = 0;
        for (int i = 1; i < n; ++i) {
            res += 9 * pow(9, i - 1);
        }
        vector<vector<vector<long long>>> dp(n, vector<vector<long long>>(2, vector<long long>(10, -1)));
        function<long long(int, bool, int)> dfs = [&](int pos, bool tight, int last) -> long long {
            if (pos == n) return 1;
            if (dp[pos][tight][last] != -1) return dp[pos][tight][last];
            int limit = tight ? s[pos] - '0' : 9;
            long long ans = 0;
            for (int d = 0; d <= limit; ++d) {
                if (d == last) continue;
                bool new_tight = tight && (d == limit);
                ans += dfs(pos + 1, new_tight, d);
            }
            return dp[pos][tight][last] = ans;
        };
        res += dfs(0, true, -1);
        return res;
    }
};