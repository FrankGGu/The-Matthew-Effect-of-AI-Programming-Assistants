class Solution {
public:
    int countGoodNumbers(long long n) {
        long long mod = 1e9 + 7;
        long long even = (n + 1) / 2;
        long long odd = n / 2;
        return (powMod(5, even, mod) * powMod(4, odd, mod)) % mod;
    }

private:
    long long powMod(long long x, long long y, long long mod) {
        long long res = 1;
        x %= mod;
        while (y > 0) {
            if (y % 2 == 1) {
                res = (res * x) % mod;
            }
            x = (x * x) % mod;
            y /= 2;
        }
        return res;
    }
};