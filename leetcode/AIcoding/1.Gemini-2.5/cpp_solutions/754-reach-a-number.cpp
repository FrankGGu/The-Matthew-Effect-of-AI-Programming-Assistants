#include <cmath> // For std::abs

class Solution {
public:
    int reachNumber(int target) {
        // Take the absolute value of the target, as moving left or right
        // is symmetric. We can always flip all signs to reach -target if we can reach target.
        target = std::abs(target);

        int n = 0;
        long long sum = 0; // Use long long for sum to prevent potential overflow
                           // as target can be up to 10^9 and sum can exceed int max.

        while (true) {
            n++;
            sum += n;

            // Condition 1: The current sum of steps (1+2+...+n) must be at least the target.
            // If sum < target, we haven't reached or surpassed the target yet.
            // Condition 2: The difference (sum - target) must be an even number.
            // Let S_n = 1 + 2 + ... + n.
            // We want to reach T by choosing some steps +i and some -i.
            // Let P be the sum of positive steps and N be the sum of negative steps.
            // P + N = S_n
            // P - N = T
            // Substituting P = S_n - N into the second equation:
            // (S_n - N) - N = T
            // S_n - 2N = T
            // S_n - T = 2N
            // This means (S_n - T) must be an even number, and S_n must be >= T.
            if (sum >= target && (sum - target) % 2 == 0) {
                return n;
            }
        }
    }
};