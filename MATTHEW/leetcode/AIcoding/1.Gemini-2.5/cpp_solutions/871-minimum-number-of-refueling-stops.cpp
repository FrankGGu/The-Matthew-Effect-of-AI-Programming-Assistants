#include <vector>
#include <queue>

class Solution {
public:
    int minRefuelStops(int target, int startFuel, std::vector<std::vector<int>>& stations) {
        long long current_fuel = startFuel;
        int stops = 0;
        std::priority_queue<int> pq; // Max-priority queue to store fuel amounts from visited stations

        // Add the target as a virtual station with 0 fuel.
        // This simplifies the loop by ensuring we always try to reach the target itself.
        // It also handles the case where the initial fuel is enough to reach the target.
        stations.push_back({target, 0});

        for (const auto& station : stations) {
            int pos = station[0];
            int fuel_at_station = station[1];

            // While we don't have enough fuel to reach the current station (or target)
            while (current_fuel < pos) {
                // If there are no previous stations we can refuel from, it's impossible to reach 'pos'
                if (pq.empty()) {
                    return -1;
                }
                // Take the largest available fuel from a previous station we passed
                current_fuel += pq.top();
                pq.pop();
                stops++;
            }

            // We have reached or passed this station. Add its fuel to our options.
            // We might not need this fuel now, but it could be useful later.
            pq.push(fuel_at_station);
        }

        return stops;
    }
};