#include <vector>
#include <algorithm>
#include <map>
#include <limits>

class Solution {
public:
    int makeArrayIncreasing(std::vector<int>& arr1, std::vector<int>& arr2) {
        std::sort(arr2.begin(), arr2.end());
        arr2.erase(std::unique(arr2.begin(), arr2.end()), arr2.end());

        // dp[operations] = minimum_last_element_value
        // Initialize with 0 operations, previous element value -1 (smaller than any possible value)
        std::map<int, int> dp;
        dp[0] = -1; 

        for (int x : arr1) {
            std::map<int, int> next_dp;
            for (auto const& [ops, prev_val] : dp) {
                // Case 1: Keep x (if x is strictly greater than prev_val)
                if (x > prev_val) {
                    // Update next_dp[ops] with x if x is smaller or ops is not yet in next_dp
                    if (next_dp.find(ops) == next_dp.end() || x < next_dp[ops]) {
                        next_dp[ops] = x;
                    }
                }

                // Case 2: Replace x with an element from arr2
                // Find the smallest element in arr2 that is strictly greater than prev_val
                auto it = std::upper_bound(arr2.begin(), arr2.end(), prev_val);
                if (it != arr2.end()) {
                    int new_val = *it;
                    // Update next_dp[ops + 1] with new_val if new_val is smaller or ops+1 is not yet in next_dp
                    if (next_dp.find(ops + 1) == next_dp.end() || new_val < next_dp[ops + 1]) {
                        next_dp[ops + 1] = new_val;
                    }
                }
            }
            dp = std::move(next_dp); 
        }

        // If dp is empty, no strictly increasing array can be formed
        if (dp.empty()) {
            return -1;
        }

        // The minimum number of operations is the smallest key in the final dp map
        // Since std::map stores keys in sorted order, dp.begin()->first gives the minimum operations
        return dp.begin()->first;
    }
};