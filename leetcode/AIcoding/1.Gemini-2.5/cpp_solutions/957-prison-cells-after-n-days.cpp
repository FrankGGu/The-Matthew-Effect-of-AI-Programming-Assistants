#include <vector>
#include <map>
#include <numeric>

int vecToInt(const std::vector<int>& cells) {
    int state = 0;
    for (int i = 0; i < 8; ++i) {
        state = (state << 1) | cells[i];
    }
    return state;
}

class Solution {
public:
    std::vector<int> prisonAfterNDays(std::vector<int>& cells, int N) {
        // Map to store the integer representation of a state to the day it first occurred.
        std::map<int, int> state_to_day_map;
        // Map to store the day number to the actual vector state.
        // This is used to retrieve the state after calculating the effective remaining days.
        std::map<int, std::vector<int>> day_to_state_map;

        // Simulate day by day up to N days
        for (int day = 0; day < N; ++day) {
            int current_state_int = vecToInt(cells);

            // Check if this state has been seen before
            if (state_to_day_map.count(current_state_int)) {
                // Cycle detected
                int prev_day = state_to_day_map[current_state_int];
                int cycle_length = day - prev_day; // Length of the detected cycle

                // Calculate how many more days we need to simulate
                int remaining_days = N - day;
                // Find the effective number of days within the cycle
                int effective_remaining_days = remaining_days % cycle_length;

                // The state after N days will be the same as the state
                // that occurred at (prev_day + effective_remaining_days) within the cycle.
                return day_to_state_map[prev_day + effective_remaining_days];
            }

            // If state is new, store it with the current day
            state_to_day_map[current_state_int] = day;
            day_to_state_map[day] = cells;

            // Calculate the next state based on current 'cells'
            std::vector<int> next_cells(8, 0); // Initialize next state with all zeros
            // Cells 0 and 7 always become 0, so only calculate for cells 1 to 6
            for (int i = 1; i < 7; ++i) {
                // A cell becomes 1 if its two adjacent cells are both 0 or both 1
                // (i.e., they are equal). Otherwise, it becomes 0.
                next_cells[i] = (cells[i-1] == cells[i+1]) ? 1 : 0;
            }
            cells = next_cells; // Update cells for the next iteration
        }

        // If N days completed without detecting a cycle (i.e., N was small enough)
        return cells;
    }
};