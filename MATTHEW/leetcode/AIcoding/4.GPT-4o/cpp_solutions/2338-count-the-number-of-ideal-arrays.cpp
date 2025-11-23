class Solution {
public:
    int idealArrays(int n, int maxValue) {
        const int MOD = 1e9 + 7;
        vector<long long> dp(maxValue + 1, 0);
        vector<long long> count(maxValue + 1, 0);

        for (int i = 1; i <= maxValue; ++i) {
            dp[i] = 1;
            for (int j = 2 * i; j <= maxValue; j += i) {
                dp[j] += dp[i];
            }
        }

        for (int i = 1; i <= maxValue; ++i) {
            count[i] = (count[i - 1] + dp[i]) % MOD;
        }

        long long result = 0;
        for (int i = 1; i <= maxValue; ++i) {
            result = (result + count[i] * modExp(i, n, MOD)) % MOD;
        }

        return result;
    }

private:
    long long modExp(long long base, long long exp, const int MOD) {
        long long res = 1;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }
};