#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int numberOfSequence(int n, vector<int>& sick) {
        const int MOD = 1e9 + 7;
        vector<long long> fact(n + 1), inv_fact(n + 1);
        fact[0] = 1;
        for (int i = 1; i <= n; ++i) {
            fact[i] = fact[i - 1] * i % MOD;
        }
        inv_fact[n] = pow_mod(fact[n], MOD - 2, MOD);
        for (int i = n - 1; i >= 0; --i) {
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % MOD;
        }

        sort(sick.begin(), sick.end());
        long long res = 1;
        int total = 0;
        for (int i = 0; i < sick.size(); ++i) {
            int prev = (i == 0) ? -1 : sick[i - 1];
            int curr = sick[i];
            int gap = curr - prev - 1;
            if (gap > 0) {
                if (prev != -1) {
                    res = res * pow_mod(2, gap - 1, MOD) % MOD;
                }
                res = res * inv_fact[gap] % MOD;
                total += gap;
            }
        }
        int last_gap = n - sick.back() - 1;
        if (last_gap > 0) {
            res = res * inv_fact[last_gap] % MOD;
            total += last_gap;
        }
        res = res * fact[total] % MOD;
        return res;
    }

private:
    long long pow_mod(long long x, int power, int MOD) {
        long long res = 1;
        while (power > 0) {
            if (power % 2 == 1) {
                res = res * x % MOD;
            }
            x = x * x % MOD;
            power /= 2;
        }
        return res;
    }
};