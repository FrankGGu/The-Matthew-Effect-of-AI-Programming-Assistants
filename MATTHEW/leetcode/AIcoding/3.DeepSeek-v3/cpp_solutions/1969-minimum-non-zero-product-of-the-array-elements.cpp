class Solution {
public:
    const int MOD = 1e9 + 7;

    long long powMod(long long base, long long exp) {
        long long res = 1;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    int minNonZeroProduct(int p) {
        long long max_num = (1LL << p) - 1;
        long long k = max_num / 2;
        long long part = powMod(max_num - 1, k);
        return (max_num % MOD) * (part % MOD) % MOD;
    }
};