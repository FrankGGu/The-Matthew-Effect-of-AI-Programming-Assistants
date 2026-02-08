#include <unordered_map>
#include <algorithm> // For std::min

class Solution {
public:
    std::unordered_map<int, int> memo;

    int minDays(int n) {
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }
        if (memo.count(n)) {
            return memo[n];
        }

        // Option 1: Reduce n to n/2.
        // This involves eating (n % 2) oranges to make n even,
        // then performing the n/2 division operation.
        // Cost: (n % 2) days for eating, 1 day for the division operation,
        // plus the minimum days to eat n/2 oranges.
        int days_to_n_div_2 = (n % 2) + 1 + minDays(n / 2);

        // Option 2: Reduce n to n/3.
        // This involves eating (n % 3) oranges to make n divisible by 3,
        // then performing the n/3 division operation.
        // Cost: (n % 3) days for eating, 1 day for the division operation,
        // plus the minimum days to eat n/3 oranges.
        int days_to_n_div_3 = (n % 3) + 1 + minDays(n / 3);

        return memo[n] = std::min(days_to_n_div_2, days_to_n_div_3);
    }
};