class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        long long mod = 1e9 + 7;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (__int128)res * base % mod;
            }
            base = (__int128)base * base % mod;
            exp /= 2;
        }
        return res;
    }

    int minNonZeroProduct(int p) {
        if (p == 1) {
            return 1;
        }
        long long mod = 1e9 + 7;

        long long max_val = (1LL << p) - 1;
        long long term2 = max_val % mod;

        long long base = (max_val - 1) % mod;

        long long exp = (1LL << (p - 1)) - 1;

        long long term1 = power(base, exp);

        long long ans = (__int128)term1 * term2 % mod;

        return ans;
    }
};