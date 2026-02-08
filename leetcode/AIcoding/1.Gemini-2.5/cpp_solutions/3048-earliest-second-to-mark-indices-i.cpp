#include <vector>
#include <numeric>
#include <algorithm>
#include <queue>
#include <map>

class Solution {
public:
    bool check(long long t, int n, const std::vector<int>& nums, const std::vector<std::vector<int>>& mark_indices) {
        // Step 1-3: Determine the latest possible mark time for each index <= t
        std::vector<int> last_op_time(n, -1);
        for (const auto& op : mark_indices) {
            int time = op[0];
            int index = op[1];
            if (time <= t) {
                last_op_time[index] = std::max(last_op_time[index], time);
            }
        }

        for (int i = 0; i < n; ++i) {
            if (last_op_time[i] == -1) {
                return false; // An index cannot be marked by time t
            }
        }

        // Step 4-6: Create events for each index's last_op_time and sort them
        std::vector<std::pair<int, int>> events;
        for (int i = 0; i < n; ++i) {
            events.push_back({last_op_time[i], i});
        }
        std::sort(events.begin(), events.end()); // Sort by time (ascending)

        // Step 7-14: Simulate time using an event-driven approach
        std::priority_queue<int> pq; // Max-heap to store nums[i] values of indices that are candidates to be marked
        long long total_sum_of_nums = 0;
        for (int x : nums) {
            total_sum_of_nums += x;
        }

        long long sum_of_chosen_nums_values = 0; // Sum of nums[i] for indices we choose to mark
        long long total_mark_ops = 0; // Count of indices we chose to mark
        long long free_slots_used = 0; // Seconds not used for marking

        long long current_s = 1; // Current simulated second
        int event_ptr = 0; // Pointer to the next event in the sorted events list

        while (current_s <= t) {
            long long next_event_time = (event_ptr < n) ? events[event_ptr].first : t + 1;

            // If pq is empty, we can fast-forward time
            if (pq.empty()) {
                long long advance_by = std::min(t + 1, next_event_time) - current_s;
                if (advance_by <= 0) { // Should only happen if current_s is exactly next_event_time
                    // No time to advance, just process events at current_s
                } else {
                    free_slots_used += advance_by;
                    current_s += advance_by;
                    if (current_s > t) break; // Advanced past t
                }
            }

            // Add all events that occur at current_s to the priority queue
            while (event_ptr < n && events[event_ptr].first == current_s) {
                pq.push(nums[events[event_ptr].second]);
                event_ptr++;
            }

            // If pq is not empty, use current_s for a mark operation
            if (!pq.empty()) {
                int val = pq.top();
                pq.pop();
                sum_of_chosen_nums_values += val;
                total_mark_ops++;
                current_s++; // Move to next second
            } else {
                // If pq is still empty after adding events at current_s, it means this second is free
                // This case is already handled by the initial `if (pq.empty())` block
                // and `current_s` would have advanced.
                // If current_s did not advance (because current_s == next_event_time),
                // and pq is empty, it means no events at current_s and pq was empty.
                // This implies we have processed all events and pq is empty.
                // The loop should then break or fast-forward.
                // To ensure current_s always advances, if no mark operation, it's a free slot.
                free_slots_used++;
                current_s++;
            }
        }

        // Step 16: Final check
        if (total_mark_ops < n) {
            return false; // Not all indices could be marked
        }

        long long total_time_for_marks_and_chosen_decrements = total_mark_ops + sum_of_chosen_nums_values;
        long long total_free_slots_available = t - total_time_for_marks_and_chosen_decrements;

        long long remaining_decrements_to_cover = total_sum_of_nums - sum_of_chosen_nums_values;

        return total_free_slots_available >= remaining_decrements_to_cover;
    }

    int earliestSecondToMarkIndices(std::vector<int>& nums, std::vector<std::vector<int>>& mark_indices) {
        int n = nums.size();
        int m = mark_indices.size();

        long long low = 1;
        long long high = 2LL * 100000 * 1000000000LL + 100000; // Max possible sum(nums[i]) + n + m, a loose upper bound
        long long ans = -1;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (check(mid, n, nums, mark_indices)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return static_cast<int>(ans);
    }
};