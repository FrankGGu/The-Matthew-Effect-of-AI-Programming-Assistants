#include <vector>
#include <numeric> // Not strictly needed for this specific solution, but often useful

class Solution {
public:
    bool carPooling(std::vector<std::vector<int>>& trips, int capacity) {
        // The maximum location is 1000.
        // We use a difference array (or sweep line array) to track passenger changes.
        // The array index represents the location, and the value represents the net change
        // in passengers at that location.
        // We need to cover locations from 0 to 1000, so an array of size 1001 is sufficient.
        std::vector<int> passenger_changes(1001, 0);

        for (const auto& trip : trips) {
            int num_passengers = trip[0];
            int start_location = trip[1];
            int end_location = trip[2]; // Passengers are dropped *at* end_location.
                                        // This means they are no longer in the car *after* end_location.
                                        // So, the decrease in passengers occurs at end_location.

            passenger_changes[start_location] += num_passengers;
            // Passengers get off at end_location. So, for any point *after* end_location,
            // these passengers are no longer in the car.
            // We only need to update if end_location is within our array bounds.
            // Given constraints (end_location <= 1000), this check is technically not strictly needed
            // as end_location will always be a valid index for passenger_changes[1001].
            if (end_location < 1001) {
                passenger_changes[end_location] -= num_passengers;
            }
        }

        int current_passengers = 0;
        // Iterate through all possible locations to calculate the current number of passengers.
        for (int i = 0; i < 1001; ++i) {
            current_passengers += passenger_changes[i];
            // If at any point the number of passengers exceeds the car's capacity,
            // it's impossible to complete all trips.
            if (current_passengers > capacity) {
                return false;
            }
        }

        // If we've iterated through all locations and never exceeded capacity,
        // then it's possible to complete all trips.
        return true;
    }
};