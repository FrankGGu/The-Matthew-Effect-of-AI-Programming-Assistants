class Solution {
public:
    int monkeyMove(int n) {
        const int MOD = 1e9 + 7;
        long long res = 1;
        long long base = 2;
        while (n > 0) {
            if (n % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            n /= 2;
        }
        return (res - 2 + MOD) % MOD;
    }
};