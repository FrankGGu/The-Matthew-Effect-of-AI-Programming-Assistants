#include <vector>
#include <map>
#include <set>
#include <algorithm>

class Solution {
public:
    std::vector<int> avoidFlood(std::vector<int>& rains) {
        int n = rains.size();
        std::vector<int> ans(n);

        // Map to store city_id -> last_day_it_rained_there
        // This helps identify if a city is currently flooded.
        std::map<int, int> flooded_cities;

        // Set to store indices of dry days (rains[i] == 0)
        // This set keeps indices sorted, allowing efficient searching for the next available dry day.
        std::set<int> dry_days_available;

        for (int i = 0; i < n; ++i) {
            int city_id = rains[i];

            if (city_id > 0) { // It rains in city_id
                ans[i] = -1; // As per problem statement, ans[i] is -1 if it rains

                // Check if this city is already flooded
                if (flooded_cities.count(city_id)) {
                    int last_flood_day = flooded_cities[city_id];

                    // We need to find a dry day 'k' such that last_flood_day < k < i.
                    // Use upper_bound to find the first dry day index 'k' that is strictly greater than last_flood_day.
                    auto it = dry_days_available.upper_bound(last_flood_day);

                    // If no such dry day exists, or the earliest available dry day is on or after the current day 'i',
                    // then it's impossible to dry the city before it floods again.
                    if (it == dry_days_available.end() || *it >= i) {
                        return {}; // Return empty array as it's impossible to avoid flood
                    }

                    // Found a suitable dry day at index *it
                    ans[*it] = city_id; // Dry this city on day *it
                    dry_days_available.erase(it); // Remove this dry day as it's now used
                }

                // Record the current day as the last day it rained in city_id
                flooded_cities[city_id] = i;

            } else { // rains[i] == 0, it's a dry day
                // Add this day's index to the set of available dry days
                dry_days_available.insert(i);
                // Placeholder for now. If this dry day is not used to dry a specific lake,
                // it can dry any arbitrary lake (e.g., lake 1 as per problem example).
                ans[i] = 1; 
            }
        }

        return ans;
    }
};