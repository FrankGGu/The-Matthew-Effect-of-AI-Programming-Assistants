class Solution {
public:
    int countHousePlacements(int n) {
        long long MOD = 1e9 + 7;

        if (n == 0) {
            return 1;
        }
        if (n == 1) {
            return 4;
        }

        long long prev2 = 1; // Represents ways for n-2 plots on one side
        long long prev1 = 2; // Represents ways for n-1 plots on one side
        long long current_ways_one_side = 0;

        for (int i = 2; i <= n; ++i) {
            current_ways_one_side = (prev1 + prev2) % MOD;
            prev2 = prev1;
            prev1 = current_ways_one_side;
        }

        return (current_ways_one_side * current_ways_one_side) % MOD;
    }
};