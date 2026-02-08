#include <vector>
#include <numeric>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    bool check(long long T, int n, const vector<int>& nums, const vector<vector<int>>& changeOperations) {
        if (T < n) {
            return false;
        }

        // Step 1: Find the last available operation time for each index within T.
        // last_op_time[i] stores the latest time t_op <= T for index i.
        vector<int> last_op_time(n, -1);
        vector<vector<int>> ops_at_time(T + 1); // ops_at_time[t] stores indices that have their last operation at time t.

        for (const auto& op : changeOperations) {
            int idx = op[0] - 1; // 0-indexed
            int time = op[1];
            if (time <= T) {
                last_op_time[idx] = max(last_op_time[idx], time);
            }
        }

        // Populate ops_at_time based on the last_op_time for each index
        for (int i = 0; i < n; ++i) {
            if (last_op_time[i] == -1) {
                return false; // Index i cannot be marked by time T
            }
            ops_at_time[last_op_time[i]].push_back(i);
        }

        // Step 2: Greedy simulation from T down to 1
        long long current_points_gained = 0; // Total points accumulated from operations used for point gain
        int marked_zero_cost_count = 0; // Count of 0-cost indices successfully marked

        // Min-heap to store nums[i] for positive-cost indices that we *tentatively decide to mark*.
        // If we run out of slots, we remove the smallest nums[i] from here to maximize points gained.
        priority_queue<int, vector<int>, greater<int>> marked_costly_pq; 

        for (long long t = T; t >= 1; --t) {
            for (int idx : ops_at_time[t]) {
                if (nums[idx] == 0) {
                    marked_zero_cost_count++;
                } else {
                    // Tentatively mark this index. Add its value to the min-heap.
                    marked_costly_pq.push(nums[idx]);
                }
            }

            // At time t, we have one slot.
            // We have 'marked_zero_cost_count' indices (0-cost) that are marked.
            // We have 'marked_costly_pq.size()' indices (positive-cost) that we tentatively plan to mark.
            // Total indices we plan to mark: 'marked_zero_cost_count + marked_costly_pq.size()'.
            // The total number of available slots from 1 to t is 't'.

            // If we have more indices planned for marking than available slots up to time t:
            if (marked_zero_cost_count + marked_costly_pq.size() > t) {
                // We must "unmark" one of the positive-cost indices to free up a slot.
                // To maximize 'current_points_gained' (which are from unmarking),
                // we should unmark the one with the smallest 'nums[i]' from 'marked_costly_pq'.
                // This 'nums[i]' will then contribute to 'current_points_gained'.
                if (!marked_costly_pq.empty()) {
                    current_points_gained += marked_costly_pq.top();
                    marked_costly_pq.pop();
                } else {
                    // This implies marked_zero_cost_count > t, meaning we have too many 0-cost marks for available slots.
                    // This should have been caught earlier or implies an impossible state.
                    return false; 
                }
            }
        }

        // After the loop, check if all 'n' indices are marked.
        if (marked_zero_cost_count + marked_costly_pq.size() < n) {
            return false; // Not all indices could be marked.
        }

        // Check the point condition:
        // current_points_gained must be >= sum of nums[i] for all positive-cost indices that we *decided to mark*.
        // This is the standard interpretation for this problem structure.
        long long sum_of_marked_costly_values = 0;
        while (!marked_costly_pq.empty()) {
            sum_of_marked_costly_values += marked_costly_pq.top();
            marked_costly_pq.pop();
        }

        return current_points_gained >= sum_of_marked_costly_values;
    }

    int earliestSecondToMarkIndices(vector<int>& nums, vector<vector<int>>& changeOperations) {
        int n = nums.size();
        int m = changeOperations.size();

        long long low = 1, high = m; // T can be at most m, as there are m operations and time_i <= m.
        int ans = -1;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (check(mid, n, nums, changeOperations)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
};