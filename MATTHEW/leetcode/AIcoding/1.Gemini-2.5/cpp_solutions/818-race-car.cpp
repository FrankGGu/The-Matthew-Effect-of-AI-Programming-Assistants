#include <queue>
#include <set>
#include <tuple>
#include <cmath>
#include <algorithm> // For std::abs

class Solution {
public:
    int racecar(int target) {
        // State: (position, speed, steps)
        std::queue<std::tuple<int, int, int>> q;
        // Visited states: (position, speed)
        std::set<std::pair<int, int>> visited;

        q.push({0, 1, 0}); // Start at position 0, speed 1, 0 steps
        visited.insert({0, 1});

        // Determine a reasonable upper bound for position and speed magnitude.
        // If 2^k is the smallest power of 2 greater than or equal to target,
        // then position can go up to approximately 2^(k+1) and speed up to 2^(k+1).
        // For target = 10000, k = 14 (2^14 = 16384). So max_val = 2^15 = 32768.
        // This is a safe upper bound for both position and speed magnitude.
        int max_val;
        if (target > 0) {
            int k = std::ceil(std::log2(target + 1));
            max_val = 2 * (1 << k);
        } else { // target is 0, though problem constraints say 1 <= target <= 10000
            max_val = 2; 
        }
        // Ensure max_val is sufficiently large for all targets up to 10000.
        // For target=10000, k=14, max_val=32768.
        // For target=1, k=1, max_val=4.
        // The value 32768 is a safe general upper bound for all targets.
        if (max_val < 32768) max_val = 32768;

        while (!q.empty()) {
            auto [curr_pos, curr_speed, curr_steps] = q.front();
            q.pop();

            if (curr_pos == target) {
                return curr_steps;
            }

            // Option 1: Accelerate ('A')
            int next_pos_A = curr_pos + curr_speed;
            int next_speed_A = curr_speed * 2;
            int next_steps_A = curr_steps + 1;

            if (visited.find({next_pos_A, next_speed_A}) == visited.end()) {
                // Pruning: only add states where position and speed magnitude are within reasonable bounds.
                // This prevents the search space from exploding.
                if (std::abs(next_pos_A) <= max_val && std::abs(next_speed_A) <= max_val) {
                    visited.insert({next_pos_A, next_speed_A});
                    q.push({next_pos_A, next_speed_A, next_steps_A});
                }
            }

            // Option 2: Reverse ('R')
            int next_pos_R = curr_pos;
            int next_speed_R = (curr_speed > 0) ? -1 : 1;
            int next_steps_R = curr_steps + 1;

            if (visited.find({next_pos_R, next_speed_R}) == visited.end()) {
                // For 'R', speed becomes -1 or 1, which are always within bounds.
                // Position does not change, so it's already within bounds if curr_pos was.
                // The general bounds check is technically redundant for R, but harmless.
                if (std::abs(next_pos_R) <= max_val && std::abs(next_speed_R) <= max_val) {
                    visited.insert({next_pos_R, next_speed_R});
                    q.push({next_pos_R, next_speed_R, next_steps_R});
                }
            }
        }
        return -1; // Should not be reached for valid targets based on problem constraints
    }
};