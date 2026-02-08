class Solution {
public:
    int superPow(int a, vector<int>& b) {
        const int MOD = 1337;
        a %= MOD;
        int result = 1;
        for (int digit : b) {
            result = powMod(result, 10, MOD);
            result = (result * powMod(a, digit, MOD)) % MOD;
        }
        return result;
    }

    int powMod(int x, int n, int mod) {
        long long res = 1;
        long long base = x;
        while (n > 0) {
            if (n % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            n /= 2;
        }
        return res;
    }
};