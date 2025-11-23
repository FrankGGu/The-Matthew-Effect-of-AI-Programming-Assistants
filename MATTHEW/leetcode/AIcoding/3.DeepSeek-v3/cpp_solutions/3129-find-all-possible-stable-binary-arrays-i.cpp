class Solution {
public:
    const int MOD = 1e9 + 7;
    int dp[101][101][2];

    int solve(int zero, int one, int last) {
        if (zero == 0 && one == 0) {
            return 1;
        }
        if (dp[zero][one][last] != -1) {
            return dp[zero][one][last];
        }
        int res = 0;
        if (last == -1) {
            if (zero > 0) {
                res = (res + solve(zero - 1, one, 0)) % MOD;
            }
            if (one > 0) {
                res = (res + solve(zero, one - 1, 1)) % MOD;
            }
        } else if (last == 0) {
            if (one > 0) {
                res = (res + solve(zero, one - 1, 1)) % MOD;
            }
        } else {
            if (zero > 0) {
                res = (res + solve(zero - 1, one, 0)) % MOD;
            }
        }
        return dp[zero][one][last] = res;
    }

    int numberOfStableArrays(int zero, int one, int limit) {
        memset(dp, -1, sizeof(dp));
        return solve(zero, one, -1);
    }
};