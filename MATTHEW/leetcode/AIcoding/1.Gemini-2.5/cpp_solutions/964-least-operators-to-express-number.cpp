#include <map>
#include <algorithm>

class Solution {
public:
    int base_x;
    std::map<long long, int> memo;

    int leastOpsExpressTarget(int x, int target) {
        base_x = x;
        memo.clear(); // Clear memoization table for each test case
        return solve(target);
    }

    int solve(long long target_val) {
        // Base case: if target_val is 0, no operators are needed.
        if (target_val == 0) {
            return 0;
        }
        // Base case: if target_val is 1, we can express it as x/x, which costs 1 operator.
        if (target_val == 1) {
            return 1;
        }

        // Check if the result for target_val is already memoized.
        if (memo.count(target_val)) {
            return memo[target_val];
        }

        long long power = 1; // Represents x^k
        int k = 0;           // Represents the exponent k for x^k

        // Find the largest k such that base_x^k <= target_val.
        // Also, check if target_val is an exact power of base_x.
        while (true) {
            // If target_val is an exact power of base_x (base_x^k)
            if (power == target_val) {
                // Cost for base_x^k:
                // If k=0 (i.e., target_val=1), cost is 1 (for x/x).
                // If k>=1, cost is k-1 (e.g., x*x costs 1, x*x*x costs 2).
                return memo[target_val] = (k == 0 ? 1 : k - 1);
            }

            // Check for overflow before multiplication: power * base_x could exceed LLONG_MAX
            // Or if power * base_x would exceed target_val, we stop.
            if (power > target_val / base_x) {
                break;
            }

            power *= base_x;
            k++;
        }
        // At this point:
        // power = base_x^k, where base_x^k < target_val < base_x^(k+1)
        // (The case target_val=1 is handled as a base case, and exact powers are returned earlier).

        int res;

        // Option 1: Express target_val as base_x^k + remainder
        // Cost to obtain base_x^k: k-1 if k >= 1, and 1 if k=0 (for 1).
        int cost_pk = (k == 0) ? 1 : k - 1;
        // Total cost = cost of base_x^k + cost of (target_val - base_x^k) + 1 (for the '+' operator)
        res = cost_pk + solve(target_val - power) + 1;

        // Option 2: Express target_val as base_x^(k+1) - remainder'
        // Cost to obtain base_x^(k+1): k. (Since it's x to the power of k+1, the cost is (k+1)-1 = k).
        long long next_power = power * base_x;
        int cost_pk_plus_1 = k;
        // Total cost = cost of base_x^(k+1) + cost of (base_x^(k+1) - target_val) + 1 (for the '-' operator)
        res = std::min(res, cost_pk_plus_1 + solve(next_power - target_val) + 1);

        // Memoize the result and return.
        return memo[target_val] = res;
    }
};