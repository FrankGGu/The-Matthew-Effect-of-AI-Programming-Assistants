#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int superEggDrop(int k, int n) {
        // dp[j] represents the maximum number of floors we can determine
        // the critical floor for, using 'm' moves and 'j' eggs.
        // We want to find the minimum 'm' such that dp[k] >= n.

        // Initialize dp array. dp[j] stores the max floors for 'm' moves and 'j' eggs.
        // dp[0] will always be 0 (0 eggs can cover 0 floors).
        std::vector<int> dp(k + 1, 0); 

        int m = 0; // Number of moves

        // Loop until we can cover 'n' floors with 'k' eggs
        while (dp[k] < n) {
            m++; // Increment the number of moves

            // Iterate from k down to 1.
            // This order is crucial because dp[j] for the current 'm' depends on
            // dp[j-1] (from previous 'm' moves) and dp[j] (from previous 'm' moves).
            // If we iterate upwards, dp[j-1] would already be updated for the current 'm',
            // which is incorrect for the dp[m-1][j-1] term.
            for (int j = k; j >= 1; --j) {
                // The recurrence relation:
                // dp[m][j] = dp[m-1][j-1] + dp[m-1][j] + 1
                //
                // If the egg breaks at the chosen floor 'x':
                //   We have 'm-1' moves left and 'j-1' eggs.
                //   We can determine dp[m-1][j-1] floors below 'x'.
                // If the egg does not break at the chosen floor 'x':
                //   We have 'm-1' moves left and 'j' eggs.
                //   We can determine dp[m-1][j] floors above 'x'.
                // The current floor 'x' itself is also covered.
                // Total floors covered = (floors below) + (floors above) + 1 (current floor)
                dp[j] = dp[j-1] + dp[j] + 1;
            }
        }

        return m;
    }
};