#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    int longestConsecutive(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        std::sort(nums.begin(), nums.end());

        std::map<int, int> dp; // dp[val] stores the maximum length of a consecutive sequence ending at 'val'
        int max_len = 0;

        for (int num : nums) {
            // Calculate potential new lengths if 'num' is used to form num-1, num, or num+1.
            // These calculations must use dp values from *before* num is processed for any of its transformations.
            // So, calculate all three potential lengths first.

            // Case 1: num becomes num-1. It extends a sequence ending at num-2.
            int len_minus_1 = 1 + dp[num - 2]; 

            // Case 2: num becomes num. It extends a sequence ending at num-1.
            int len_zero = 1 + dp[num - 1];

            // Case 3: num becomes num+1. It extends a sequence ending at num.
            int len_plus_1 = 1 + dp[num];

            // Update dp values.
            // It's crucial to update from largest target value to smallest (num+1, then num, then num-1).
            // This ensures that when we use dp[k] for a calculation (e.g., dp[num] for len_plus_1),
            // it refers to a sequence formed by elements strictly before the current 'num'
            // or a different 'num' that resulted in 'k', not 'num' itself.

            // Update for num+1
            dp[num + 1] = std::max(dp[num + 1], len_plus_1);
            // Update for num
            dp[num] = std::max(dp[num], len_zero);
            // Update for num-1
            dp[num - 1] = std::max(dp[num - 1], len_minus_1);

            // Update overall maximum length considering the newly updated dp values
            max_len = std::max({max_len, dp[num - 1], dp[num], dp[num + 1]});
        }

        return max_len;
    }
};