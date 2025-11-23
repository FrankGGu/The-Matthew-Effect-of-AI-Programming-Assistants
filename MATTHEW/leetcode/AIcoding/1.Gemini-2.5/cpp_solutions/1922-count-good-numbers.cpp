class Solution {
public:
    int countGoodNumbers(long long n) {
        long long MOD = 1e9 + 7;
        long long even_count = (n + 1) / 2;
        long long odd_count = n / 2;

        long long even_perms = power(5, even_count, MOD);
        long long odd_perms = power(4, odd_count, MOD);

        return (int)((even_perms * odd_perms) % MOD);
    }

private:
    long long power(long long base, long long exp, long long mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
};