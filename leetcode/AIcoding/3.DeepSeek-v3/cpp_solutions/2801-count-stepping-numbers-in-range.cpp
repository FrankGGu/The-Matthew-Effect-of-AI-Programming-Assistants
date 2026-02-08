class Solution {
public:
    int countSteppingNumbers(string low, string high) {
        return (countNumbers(high) - countNumbers(low) + isStepping(low) + MOD) % MOD;
    }

private:
    const int MOD = 1e9 + 7;
    string s;
    int memo[101][10][2][2];

    int countNumbers(const string &num) {
        s = num;
        memset(memo, -1, sizeof(memo));
        return dfs(0, 0, true, true);
    }

    int dfs(int pos, int prev, bool isLeading, bool isTight) {
        if (pos == s.size()) {
            return isLeading ? 0 : 1;
        }
        if (memo[pos][prev][isLeading][isTight] != -1) {
            return memo[pos][prev][isLeading][isTight];
        }
        int limit = isTight ? s[pos] - '0' : 9;
        int res = 0;
        for (int d = 0; d <= limit; ++d) {
            bool newIsLeading = isLeading && (d == 0);
            bool newIsTight = isTight && (d == limit);
            if (newIsLeading) {
                res = (res + dfs(pos + 1, d, newIsLeading, newIsTight)) % MOD;
            } else {
                if (isLeading || abs(d - prev) == 1) {
                    res = (res + dfs(pos + 1, d, newIsLeading, newIsTight)) % MOD;
                }
            }
        }
        memo[pos][prev][isLeading][isTight] = res;
        return res;
    }

    bool isStepping(const string &num) {
        for (int i = 1; i < num.size(); ++i) {
            if (abs(num[i] - num[i - 1]) != 1) {
                return false;
            }
        }
        return true;
    }
};