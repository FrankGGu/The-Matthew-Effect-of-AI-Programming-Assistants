#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    int latestTimeCatchTheBus(std::vector<int>& buses, std::vector<int>& passengers, int capacity) {
        std::sort(buses.begin(), buses.end());
        std::sort(passengers.begin(), passengers.end());

        int n = buses.size();
        int m = passengers.size();
        int p_ptr = 0; // Pointer for passengers

        std::set<int> boarded_times; // Stores arrival times of all passengers who boarded any bus

        int last_bus_departure_time = 0;
        int last_bus_passengers_count = 0;
        int last_passenger_on_last_bus_time = -1;

        for (int i = 0; i < n; ++i) {
            int current_bus_time = buses[i];
            int current_bus_passengers = 0;
            int current_last_p_time = -1;

            while (p_ptr < m && passengers[p_ptr] <= current_bus_time && current_bus_passengers < capacity) {
                boarded_times.insert(passengers[p_ptr]);
                current_last_p_time = passengers[p_ptr];
                current_bus_passengers++;
                p_ptr++;
            }

            if (i == n - 1) { // This is the last bus
                last_bus_departure_time = current_bus_time;
                last_bus_passengers_count = current_bus_passengers;
                last_passenger_on_last_bus_time = current_last_p_time;
            }
        }

        int ans;
        if (last_bus_passengers_count < capacity) {
            // The last bus has empty seats. We can potentially arrive at its departure time.
            ans = last_bus_departure_time;
        } else {
            // The last bus is full. We must have arrived before the last passenger who boarded it.
            // last_passenger_on_last_bus_time must be valid here since capacity > 0 and bus is full.
            ans = last_passenger_on_last_bus_time - 1;
        }

        // Decrement ans until we find a time slot that is not taken by an existing passenger
        while (boarded_times.count(ans)) {
            ans--;
        }

        return ans;
    }
};