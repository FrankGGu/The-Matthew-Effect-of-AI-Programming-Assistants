class Solution {
public:
    int countGoodNumbers(long long n) {
        long long mod = 1e9 + 7;
        long long evenCount = (n + 1) / 2;
        long long oddCount = n / 2;
        long long evenWays = power(5, evenCount, mod);
        long long oddWays = power(4, oddCount, mod);
        return (evenWays * oddWays) % mod;
    }

    long long power(long long x, long long y, long long mod) {
        long long res = 1;
        while (y > 0) {
            if (y % 2 == 1) res = (res * x) % mod;
            x = (x * x) % mod;
            y /= 2;
        }
        return res;
    }
};