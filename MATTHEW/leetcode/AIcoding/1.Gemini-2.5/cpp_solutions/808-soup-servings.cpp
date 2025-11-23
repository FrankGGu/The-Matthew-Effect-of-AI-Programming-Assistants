#include <vector>
#include <cmath>
#include <iomanip>

class Solution {
public:
    std::vector<std::vector<double>> memo;

    double solve(int a, int b) {
        if (a <= 0 && b <= 0) {
            return 0.5; // A and B run out simultaneously
        }
        if (a <= 0) {
            return 1.0; // A runs out first
        }
        if (b <= 0) {
            return 0.0; // B runs out first
        }

        if (memo[a][b] != -1.0) {
            return memo[a][b];
        }

        double prob = 0.0;
        // Option 1: Serve (100, 0) -> (4, 0) units of 25ml
        prob += 0.25 * solve(a - 4, b);
        // Option 2: Serve (75, 25) -> (3, 1) units
        prob += 0.25 * solve(a - 3, b - 1);
        // Option 3: Serve (50, 50) -> (2, 2) units
        prob += 0.25 * solve(a - 2, b - 2);
        // Option 4: Serve (25, 75) -> (1, 3) units
        prob += 0.25 * solve(a - 1, b - 3);

        return memo[a][b] = prob;
    }

    double soupServings(int n) {
        // For large N, the probability converges to 0.5
        // An empirical threshold is around 4800.
        // Beyond this, the probability is effectively 0.5.
        if (n >= 4800) {
            return 0.5;
        }

        // Scale N by dividing by 25 and taking the ceiling
        // x represents the number of 25ml units of soup
        // (n + 24) / 25 is equivalent to ceil(n / 25.0) for n >= 0
        int x = (n + 24) / 25;

        // Initialize memoization table with -1.0 to indicate uncomputed states
        // The maximum value for x when n < 4800 is for n=4799: (4799+24)/25 = 192.92 -> 192
        // So, a size of (192+1) x (192+1) is sufficient.
        memo.assign(x + 1, std::vector<double>(x + 1, -1.0));

        return solve(x, x);
    }
};