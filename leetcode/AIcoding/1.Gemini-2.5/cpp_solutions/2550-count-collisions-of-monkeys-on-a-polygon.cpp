class Solution {
private:
    long long MOD = 1e9 + 7;

    long long power(long long base, long long exp) {
        long long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

public:
    int countCollisions(int n) {
        long long total_ways = power(2, n);
        long long result = (total_ways - 2 + MOD) % MOD;
        return static_cast<int>(result);
    }
};