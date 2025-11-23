#include <vector>
#include <algorithm>

class Solution {
public:
    int longestSubarray(std::vector<int>& nums) {
        int max_val = 0;
        for (int num : nums) {
            if (num > max_val) {
                max_val = num;
            }
        }

        int max_count = 0;
        int current_count = 0;

        for (int num : nums) {
            if (num == max_val) {
                current_count++;
            } else {
                current_count = 0;
            }
            if (current_count > max_count) {
                max_count = current_count;
            }
        }

        return max_count;
    }
};