class Solution {
public:
    int numberOfSequence(int n, vector<int>& sick) {
        const int MOD = 1e9 + 7;
        vector<int> fact(n + 1);
        fact[0] = 1;
        for (int i = 1; i <= n; ++i) {
            fact[i] = (long long)fact[i - 1] * i % MOD;
        }

        vector<int> inv_fact(n + 1);
        inv_fact[n] = power(fact[n], MOD - 2, MOD);
        for (int i = n - 1; i >= 0; --i) {
            inv_fact[i] = (long long)inv_fact[i + 1] * (i + 1) % MOD;
        }

        int m = sick.size();
        long long res = 1;
        int total = 0;

        for (int i = 0; i < m - 1; ++i) {
            int diff = sick[i + 1] - sick[i] - 1;
            if (diff > 0) {
                res = res * power(2, diff - 1, MOD) % MOD;
                res = res * inv_fact[diff] % MOD;
                total += diff;
            }
        }

        if (sick[0] > 0) {
            int diff = sick[0];
            res = res * inv_fact[diff] % MOD;
            total += diff;
        }

        if (sick.back() < n - 1) {
            int diff = n - 1 - sick.back();
            res = res * inv_fact[diff] % MOD;
            total += diff;
        }

        res = res * fact[total] % MOD;
        return res;
    }

private:
    int power(int x, int y, int MOD) {
        int res = 1;
        x %= MOD;
        while (y > 0) {
            if (y & 1) {
                res = (long long)res * x % MOD;
            }
            x = (long long)x * x % MOD;
            y >>= 1;
        }
        return res;
    }
};