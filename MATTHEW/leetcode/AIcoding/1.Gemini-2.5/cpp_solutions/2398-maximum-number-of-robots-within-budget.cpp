#include <vector>
#include <deque>
#include <algorithm> // For std::max

class Solution {
public:
    int maximumRobots(std::vector<int>& chargeTimes, std::vector<int>& runningCosts, long long budget) {
        int n = chargeTimes.size();
        if (n == 0) {
            return 0;
        }

        int left = 0;
        long long current_sum_running_costs = 0;
        int max_len = 0;
        std::deque<int> dq; // Stores indices of chargeTimes in decreasing order of values

        for (int right = 0; right < n; ++right) {
            // Maintain deque for maximum chargeTime in current window [left, right]
            while (!dq.empty() && chargeTimes[dq.back()] <= chargeTimes[right]) {
                dq.pop_back();
            }
            dq.push_back(right);

            // Add current runningCost to sum
            current_sum_running_costs += runningCosts[right];

            // Shrink window from left if budget exceeded
            while (true) {
                // If the window is empty or invalid, break. This can happen if left > right.
                if (left > right) {
                    break;
                }

                long long current_max_charge_time = chargeTimes[dq.front()];
                long long current_window_length = right - left + 1;
                long long current_cost = current_max_charge_time + current_sum_running_costs * current_window_length;

                if (current_cost <= budget) {
                    break; // Window is valid, exit inner while loop
                }

                // Window is invalid, shrink from left
                current_sum_running_costs -= runningCosts[left];
                if (dq.front() == left) {
                    dq.pop_front();
                }
                left++;
            }

            // After shrinking (if necessary), the window [left, right] is valid
            // or left > right (empty window).
            // Only update max_len if the window is valid (left <= right).
            if (left <= right) {
                max_len = std::max(max_len, right - left + 1);
            }
        }

        return max_len;
    }
};