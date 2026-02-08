class Solution {
public:
    int countHousePlacements(int n) {
        const int MOD = 1e9 + 7;
        if (n == 1) return 4;
        long long prev = 2, prev_prev = 1;
        for (int i = 2; i <= n; ++i) {
            long long current = (prev + prev_prev) % MOD;
            prev_prev = prev;
            prev = current;
        }
        return (prev * prev) % MOD;
    }
};