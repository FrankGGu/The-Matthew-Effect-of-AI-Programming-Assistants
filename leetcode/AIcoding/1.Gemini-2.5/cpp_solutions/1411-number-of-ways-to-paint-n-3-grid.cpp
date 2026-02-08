class Solution {
public:
    int numOfWays(int n) {
        long long aba_count = 6; // Number of ways to paint a row with pattern like RGR (2 colors)
        long long abc_count = 6; // Number of ways to paint a row with pattern like RGB (3 colors)
        long long MOD = 1e9 + 7;

        for (int i = 2; i <= n; ++i) {
            long long next_aba_count = (2 * aba_count + 2 * abc_count) % MOD;
            long long next_abc_count = (4 * aba_count + 3 * abc_count) % MOD;

            aba_count = next_aba_count;
            abc_count = next_abc_count;
        }

        return (aba_count + abc_count) % MOD;
    }
};