#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int countElements(std::vector<int>& nums) {
        if (nums.size() < 3) {
            return 0;
        }

        int minVal = nums[0];
        int maxVal = nums[0];

        for (int num : nums) {
            if (num < minVal) {
                minVal = num;
            }
            if (num > maxVal) {
                maxVal = num;
            }
        }

        if (minVal == maxVal) {
            return 0;
        }

        int count = 0;
        for (int num : nums) {
            if (num > minVal && num < maxVal) {
                count++;
            }
        }

        return count;
    }
};