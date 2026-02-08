class Solution {
public:
    int sumOfGoodNumbers(long long n) {
        const int MOD = 1e9 + 7;
        long long evenCount = (n + 1) / 2;
        long long oddCount = n / 2;
        long long powerOf5 = 1;
        long long powerOf4 = 1;

        for (int i = 0; i < evenCount; ++i) {
            powerOf5 = (powerOf5 * 5) % MOD;
        }
        for (int i = 0; i < oddCount; ++i) {
            powerOf4 = (powerOf4 * 4) % MOD;
        }

        return (powerOf5 * powerOf4) % MOD;
    }
};