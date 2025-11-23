#include <vector>
#include <algorithm>

class Solution {
public:
    int longestAlternatingSubarray(std::vector<int>& nums, int threshold) {
        int n = nums.size();
        int maxLength = 0;
        int i = 0;
        while (i < n) {
            if (nums[i] > threshold || nums[i] % 2 != 0) {
                i++;
                continue;
            }

            int j = i + 1;
            while (j < n && nums[j] <= threshold && nums[j] % 2 != nums[j - 1] % 2) {
                j++;
            }

            maxLength = std::max(maxLength, j - i);
            i = j;
        }
        return maxLength;
    }
};