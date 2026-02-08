class Solution {
public:
    int maxNiceDivisors(int n) {
        if (n <= 3) return n;
        long long mod = 1e9 + 7;
        long long a = n / 3, b = n % 3;
        if (b == 0) return power(3, a, mod);
        else if (b == 1) return (power(3, a - 1, mod) * 4) % mod;
        else return (power(3, a, mod) * 2) % mod;
    }

    long long power(long long x, long long y, long long mod) {
        long long res = 1;
        while (y > 0) {
            if (y & 1) res = (res * x) % mod;
            x = (x * x) % mod;
            y >>= 1;
        }
        return res;
    }
};