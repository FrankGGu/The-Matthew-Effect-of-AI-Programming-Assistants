#include <vector>
#include <numeric>
#include <cmath> // For std::abs

class Solution {
public:
    int countRoutes(std::vector<int>& locations, int start, int end, int fuel) {
        int n = locations.size();
        long long MOD = 1e9 + 7;

        // dp[city_idx][fuel_left] stores the number of ways to reach city_idx with fuel_left
        std::vector<std::vector<long long>> dp(n, std::vector<long long>(fuel + 1, 0));

        // Base case: We start at 'start' city with 'fuel' fuel.
        dp[start][fuel] = 1;

        long long total_routes = 0;

        // Iterate through fuel amounts from max fuel down to 0
        // This ensures that when we calculate dp[next_city][new_fuel],
        // dp[curr_city][f] for higher fuel amounts has already been processed.
        for (int f = fuel; f >= 0; --f) {
            // Iterate through each city
            for (int curr_city = 0; curr_city < n; ++curr_city) {
                // If there are no ways to reach curr_city with f fuel, skip
                if (dp[curr_city][f] == 0) {
                    continue;
                }

                // If curr_city is the end city, all paths leading here count as a valid route
                // The value dp[curr_city][f] represents the number of ways to arrive at curr_city
                // with f fuel. If curr_city is the end, these are valid routes.
                if (curr_city == end) {
                    total_routes = (total_routes + dp[curr_city][f]) % MOD;
                }

                // Explore all possible next cities from curr_city
                for (int next_city = 0; next_city < n; ++next_city) {
                    // Cannot move to the same city
                    if (next_city == curr_city) {
                        continue;
                    }

                    int cost = std::abs(locations[curr_city] - locations[next_city]);

                    // If we have enough fuel to make this move
                    if (f >= cost) {
                        int new_fuel = f - cost;
                        // Add the number of ways to reach curr_city with f fuel
                        // to the ways to reach next_city with new_fuel
                        dp[next_city][new_fuel] = (dp[next_city][new_fuel] + dp[curr_city][f]) % MOD;
                    }
                }
            }
        }

        return static_cast<int>(total_routes);
    }
};