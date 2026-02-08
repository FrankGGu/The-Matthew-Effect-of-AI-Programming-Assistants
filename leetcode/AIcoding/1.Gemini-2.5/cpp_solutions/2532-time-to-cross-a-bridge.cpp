#include <vector>
#include <queue>
#include <utility> // for std::pair
#include <limits> // for std::numeric_limits

class Solution {
public:
    long long getTimeWhenAllBoxesAreDelivered(int n, int k, std::vector<std::vector<int>>& workers) {
        // left_bank_waiting: Stores workers waiting on the left bank to cross to the right.
        // Priority: (leftToRight_time, worker_idx) - smallest time, then smallest index.
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> left_bank_waiting;

        // right_bank_waiting: Stores workers waiting on the right bank to cross to the left.
        // Priority: (rightToLeft_time, worker_idx) - smallest time, then smallest index.
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> right_bank_waiting;

        // left_to_right_crossing: Stores workers currently crossing from left to right or just finished on the right side.
        // Priority: (finish_time, worker_idx) - earliest finish time.
        std::priority_queue<std::pair<long long, int>, std::vector<std::pair<long long, int>>, std::greater<std::pair<long long, int>>> left_to_right_crossing;

        // right_to_left_crossing: Stores workers currently crossing from right to left or just finished on the left side.
        // Priority: (finish_time, worker_idx) - earliest finish time.
        std::priority_queue<std::pair<long long, int>, std::vector<std::pair<long long, int>>, std::greater<std::pair<long long, int>>> right_to_left_crossing;

        long long current_time = 0; // Represents the time the bridge is currently free and decisions are made
        int boxes_moved = 0;

        // Initially, all workers are on the left bank
        for (int i = 0; i < n; ++i) {
            left_bank_waiting.push({workers[i][0], i});
        }

        while (boxes_moved < k) {
            // If no workers are ready on either bank, we must advance current_time to the earliest bridge completion.
            // This ensures current_time always represents a valid point where an action can be taken.
            if (left_bank_waiting.empty() && right_bank_waiting.empty()) {
                long long next_finish_time = std::numeric_limits<long long>::max();
                if (!left_to_right_crossing.empty()) {
                    next_finish_time = std::min(next_finish_time, left_to_right_crossing.top().first);
                }
                if (!right_to_left_crossing.empty()) {
                    next_finish_time = std::min(next_finish_time, right_to_left_crossing.top().first);
                }
                // Update current_time to the earliest time a worker finishes crossing, ensuring time only moves forward.
                current_time = std::max(current_time, next_finish_time); 
            }

            // Step 1: Release workers from bridges to banks whose finish_time <= current_time
            // All workers who finished by current_time are moved to their respective banks.
            while (!left_to_right_crossing.empty() && left_to_right_crossing.top().first <= current_time) {
                auto [finish_t, worker_idx] = left_to_right_crossing.top();
                left_to_right_crossing.pop();
                right_bank_waiting.push({workers[worker_idx][1], worker_idx});
            }
            while (!right_to_left_crossing.empty() && right_to_left_crossing.top().first <= current_time) {
                auto [finish_t, worker_idx] = right_to_left_crossing.top();
                right_to_left_crossing.pop();
                left_bank_waiting.push({workers[worker_idx][0], worker_idx});
            }

            // Step 2: Decide who crosses the bridge
            // Only one worker can be on the bridge at any given time.
            // Priority: Workers on the right bank always cross first.
            if (!right_bank_waiting.empty()) {
                auto [r_to_l_time, worker_idx] = right_bank_waiting.top();
                right_bank_waiting.pop();
                // Worker starts crossing at current_time. Bridge is occupied until current_time + crossing_duration.
                // Update current_time to reflect when the bridge becomes free again.
                current_time += workers[worker_idx][1]; 
                right_to_left_crossing.push({current_time, worker_idx});
            }
            // Priority: Left to Right (only if no one crossed R->L AND we still need to move boxes)
            else if (!left_bank_waiting.empty() && boxes_moved < k) {
                auto [l_to_r_time, worker_idx] = left_bank_waiting.top();
                left_bank_waiting.pop();
                // Worker starts crossing at current_time. Bridge is occupied until current_time + crossing_duration.
                // Update current_time to reflect when the bridge becomes free again.
                current_time += workers[worker_idx][0]; 
                left_to_right_crossing.push({current_time, worker_idx});
                boxes_moved++;
                if (boxes_moved == k) {
                    return current_time; // This is the time the last box is delivered
                }
            }
            // If we reach here, and boxes_moved < k, it means both banks were empty and no one crossed.
            // This case is handled by the initial `if (left_bank_waiting.empty() && right_bank_waiting.empty())` block,
            // which would have advanced `current_time` to the next event. So, this else branch should not be explicitly needed.
        }
        return current_time; // This line should ideally not be reached if k > 0, as the return happens inside the loop.
    }
};