#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    long long maximumEnergy(std::vector<int>& energy, int k) {
        int n = energy.size();

        // dp[i] will store the maximum energy collected if we start at index i
        // and continue jumping by k steps.
        // Using long long to prevent potential overflow, as sums can be large.
        std::vector<long long> dp(n);

        // Iterate from right to left to build up the DP states.
        // The value dp[i] depends on dp[i+k].
        for (int i = n - 1; i >= 0; --i) {
            // The energy at the current position is always included.
            dp[i] = energy[i];

            // If a jump of k steps is possible from index i,
            // add the maximum energy obtainable from that next position.
            if (i + k < n) {
                dp[i] += dp[i + k];
            }
        }

        // The problem states that we can start our journey at any index i (0 <= i < n).
        // Each dp[i] represents the total energy collected for a path starting at i.
        // Therefore, the maximum energy we can collect is the maximum value found in the dp array.

        // Initialize max_energy with the energy from the first possible starting point.
        // Since energy values can be negative, we might need a large negative initial value
        // or simply take the first element and iterate from the second.
        long long max_energy = dp[0];

        // Find the maximum value across all possible starting points.
        for (int i = 1; i < n; ++i) {
            max_energy = std::max(max_energy, dp[i]);
        }

        return max_energy;
    }
};