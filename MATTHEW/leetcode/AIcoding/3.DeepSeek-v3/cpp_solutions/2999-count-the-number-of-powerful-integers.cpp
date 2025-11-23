class Solution {
public:
    long long numberOfPowerfulInt(long long start, long long end, int limit, string s) {
        return calculate(end, limit, s) - calculate(start - 1, limit, s);
    }

private:
    long long calculate(long long num, int limit, string s) {
        string upper = to_string(num);
        int n = upper.size();
        int m = s.size();
        if (n < m) return 0;

        long long dp[n][2][2];
        memset(dp, -1, sizeof(dp));

        function<long long(int, bool, bool)> dfs = [&](int pos, bool tight, bool isNum) -> long long {
            if (pos == n) {
                return isNum ? 1 : 0;
            }
            if (dp[pos][tight][isNum] != -1) {
                return dp[pos][tight][isNum];
            }

            long long res = 0;
            int maxDigit = tight ? (upper[pos] - '0') : 9;
            if (!isNum) {
                res += dfs(pos + 1, false, false);
                for (int d = 1; d <= min(maxDigit, limit); ++d) {
                    res += dfs(pos + 1, tight && (d == maxDigit), true);
                }
            } else {
                if (pos <= n - m) {
                    for (int d = 0; d <= min(maxDigit, limit); ++d) {
                        res += dfs(pos + 1, tight && (d == maxDigit), true);
                    }
                } else {
                    int idx = pos - (n - m);
                    int required = s[idx] - '0';
                    if (required > maxDigit || required > limit) {
                        return dp[pos][tight][isNum] = 0;
                    }
                    res += dfs(pos + 1, tight && (required == maxDigit), true);
                }
            }
            return dp[pos][tight][isNum] = res;
        };

        return dfs(0, true, false);
    }
};