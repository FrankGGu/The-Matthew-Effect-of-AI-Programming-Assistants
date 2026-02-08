#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    long long maxTaxiEarnings(int n, std::vector<std::vector<int>>& rides) {
        // dp[i] will store the maximum earnings possible considering rides that end at or before point i.
        // The points are 1-indexed, so we need an array of size n+1.
        // Earnings can be large, so dp array stores long long.
        std::vector<long long> dp(n + 1, 0);

        // Group rides by their end points for efficient lookup.
        // rides_ending_at[i] will store pairs of {start_point, earnings_for_this_ride}
        // for all rides that end at point i.
        // The earnings for a single ride (end - start + tip) fit within an int.
        std::vector<std::vector<std::pair<int, int>>> rides_ending_at(n + 1);

        for (const auto& ride : rides) {
            int start = ride[0];
            int end = ride[1];
            int tip = ride[2];
            int earnings_for_this_ride = end - start + tip;
            rides_ending_at[end].push_back({start, earnings_for_this_ride});
        }

        // Iterate through each possible end point from 1 to n.
        for (int i = 1; i <= n; ++i) {
            // Option 1: Do not take any ride that ends exactly at point i.
            // In this case, the maximum earnings are the same as for point i-1.
            dp[i] = dp[i-1];

            // Option 2: Consider taking rides that end exactly at point i.
            for (const auto& ride_info : rides_ending_at[i]) {
                int start = ride_info.first;
                int earnings_this_ride = ride_info.second;

                // If we take this ride, the total earnings are earnings_this_ride
                // plus the maximum earnings from rides that finished by 'start'.
                // dp[start] gives maximum earnings up to point 'start'.
                dp[i] = std::max(dp[i], dp[start] + earnings_this_ride);
            }
        }

        // The maximum earnings considering all rides up to point n.
        return dp[n];
    }
};