#include <vector>
#include <numeric>

class Solution {
public:
    int minimumArrayLength(std::vector<int>& nums) {
        int minVal = *std::min_element(nums.begin(), nums.end());
        int count = 0;
        for (int num : nums) {
            if (num % minVal == 0) {
                count++;
            }
        }
        if (count > (nums.size() + 1) / 2) {
            return (count + 1) / 2;
        } else {
            return count;
        }
    }
};