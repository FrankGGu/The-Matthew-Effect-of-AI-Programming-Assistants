class Solution {
public:
    int stringCount(int n) {
        const int MOD = 1e9 + 7;
        if (n < 4) return 0;

        long total = modPow(26, n, MOD);
        long no_l = modPow(25, n, MOD);
        long no_t = modPow(25, n, MOD);
        long no_e = modPow(25, n, MOD);
        long no_lt = modPow(24, n, MOD);
        long no_le = modPow(24, n, MOD);
        long no_te = modPow(24, n, MOD);
        long no_lte = modPow(23, n, MOD);

        long valid = (total - no_l - no_t - no_e + no_lt + no_le + no_te - no_lte) % MOD;
        return (valid + MOD) % MOD;
    }

private:
    long modPow(long x, long y, int mod) {
        long res = 1;
        x = x % mod;
        while (y > 0) {
            if (y & 1) res = (res * x) % mod;
            y = y >> 1;
            x = (x * x) % mod;
        }
        return res;
    }
};