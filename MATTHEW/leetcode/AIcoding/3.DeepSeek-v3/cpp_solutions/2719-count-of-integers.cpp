class Solution {
public:
    const int MOD = 1e9 + 7;
    int count(string num1, string num2, int min_sum, int max_sum) {
        return (calc(num2, min_sum, max_sum) - calc(num1, min_sum, max_sum) + MOD) % MOD;
    }

    int calc(string num, int min_sum, int max_sum) {
        int n = num.size();
        vector<vector<vector<int>>> memo(n, vector<vector<int>>(2, vector<int>(max_sum + 1, -1)));
        return dfs(num, 0, true, 0, min_sum, max_sum, memo);
    }

    int dfs(string &num, int pos, bool tight, int sum, int min_sum, int max_sum, vector<vector<vector<int>>> &memo) {
        if (pos == num.size()) {
            return sum >= min_sum && sum <= max_sum ? 1 : 0;
        }
        if (memo[pos][tight][sum] != -1) {
            return memo[pos][tight][sum];
        }
        int limit = tight ? num[pos] - '0' : 9;
        int res = 0;
        for (int d = 0; d <= limit; ++d) {
            bool new_tight = tight && (d == limit);
            int new_sum = sum + d;
            if (new_sum > max_sum) continue;
            res = (res + dfs(num, pos + 1, new_tight, new_sum, min_sum, max_sum, memo)) % MOD;
        }
        memo[pos][tight][sum] = res;
        return res;
    }
};