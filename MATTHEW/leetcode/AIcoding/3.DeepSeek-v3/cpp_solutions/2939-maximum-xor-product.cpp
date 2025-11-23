class Solution {
public:
    int maximumXorProduct(long long a, long long b, int n) {
        const int MOD = 1e9 + 7;
        for (long long i = n - 1; i >= 0; --i) {
            long long mask = 1LL << i;
            if ((a & mask) == (b & mask)) {
                a |= mask;
                b |= mask;
            } else {
                if (a < b) {
                    a |= mask;
                    b &= ~mask;
                } else {
                    b |= mask;
                    a &= ~mask;
                }
            }
        }
        return (a % MOD) * (b % MOD) % MOD;
    }
};