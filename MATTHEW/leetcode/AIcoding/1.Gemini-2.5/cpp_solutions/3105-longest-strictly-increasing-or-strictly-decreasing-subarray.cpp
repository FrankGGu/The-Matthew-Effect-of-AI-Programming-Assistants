#include <vector>
#include <algorithm>

class Solution {
public:
    int longestSubarray(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return n;
        }

        int max_len = 1;
        int inc_len = 1;
        int dec_len = 1;

        for (int i = 1; i < n; ++i) {
            if (nums[i] > nums[i - 1]) {
                inc_len++;
                dec_len = 1;
            } else if (nums[i] < nums[i - 1]) {
                dec_len++;
                inc_len = 1;
            } else { // nums[i] == nums[i-1]
                inc_len = 1;
                dec_len = 1;
            }
            max_len = std::max({max_len, inc_len, dec_len});
        }

        return max_len;
    }
};