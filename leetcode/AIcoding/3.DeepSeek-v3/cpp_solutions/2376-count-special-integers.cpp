class Solution {
public:
    int countSpecialNumbers(int n) {
        string s = to_string(n);
        int m = s.size();
        vector<vector<vector<int>>> memo(m, vector<vector<int>>(1 << 10, vector<int>(2, -1)));
        return dfs(0, 0, true, s, memo);
    }

    int dfs(int pos, int mask, bool is_tight, string& s, vector<vector<vector<int>>>& memo) {
        if (pos == s.size()) {
            return mask != 0;
        }
        if (memo[pos][mask][is_tight] != -1) {
            return memo[pos][mask][is_tight];
        }
        int limit = is_tight ? s[pos] - '0' : 9;
        int res = 0;
        for (int d = 0; d <= limit; ++d) {
            if (mask & (1 << d)) continue;
            bool new_is_tight = is_tight && (d == limit);
            int new_mask = (mask == 0 && d == 0) ? mask : (mask | (1 << d));
            res += dfs(pos + 1, new_mask, new_is_tight, s, memo);
        }
        memo[pos][mask][is_tight] = res;
        return res;
    }
};