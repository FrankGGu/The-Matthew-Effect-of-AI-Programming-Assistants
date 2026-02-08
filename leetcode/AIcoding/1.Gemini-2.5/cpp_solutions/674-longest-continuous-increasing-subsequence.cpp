#include <vector>
#include <algorithm>

class Solution {
public:
    int findLengthOfLCIS(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        int maxLength = 1;
        int currentLength = 1;

        for (size_t i = 1; i < nums.size(); ++i) {
            if (nums[i] > nums[i - 1]) {
                currentLength++;
            } else {
                currentLength = 1;
            }
            maxLength = std::max(maxLength, currentLength);
        }

        return maxLength;
    }
};