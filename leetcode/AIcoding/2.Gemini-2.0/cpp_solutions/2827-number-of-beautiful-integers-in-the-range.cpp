#include <vector>

using namespace std;

class Solution {
public:
    long long beautifulIntegers(int n, int k, int min_len) {
        string s = to_string(n);
        int len = s.length();
        long long ans = solve(s, k, min_len);
        return ans;
    }

private:
    long long solve(string s, int k, int min_len) {
        int len = s.length();
        if (len < min_len) return 0;

        vector<vector<vector<long long>>> dp(len + 1, vector<vector<long long>>(k, vector<long long>(2, -1)));

        function<long long(int, int, bool)> dfs = [&](int idx, int rem, bool is_limit) {
            if (idx == len) {
                return rem == 0;
            }

            if (dp[idx][rem][is_limit] != -1) {
                return dp[idx][rem][is_limit];
            }

            long long res = 0;
            int up = is_limit ? s[idx] - '0' : 9;

            for (int i = 0; i <= up; ++i) {
                res += dfs(idx + 1, (rem * 10 + i) % k, is_limit && (i == up));
            }

            return dp[idx][rem][is_limit] = res;
        };

        return dfs(0, 0, true);
    }
};

long long countBeautifulIntegers(int low, int high, int k) {
    Solution sol;
    long long ans = sol.beautifulIntegers(high, k, to_string(k).length()) - sol.beautifulIntegers(low - 1, k, to_string(k).length());
    return ans;
}
};