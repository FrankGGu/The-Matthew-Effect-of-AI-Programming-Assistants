#include <vector>

class Solution {
public:
    int countSubarraysOfLengthThreeWithCondition(std::vector<int>& nums) {
        int count = 0;
        if (nums.size() < 3) {
            return 0;
        }

        for (int i = 0; i <= (int)nums.size() - 3; ++i) {
            bool strictlyIncreasing = (nums[i] < nums[i+1] && nums[i+1] < nums[i+2]);
            bool strictlyDecreasing = (nums[i] > nums[i+1] && nums[i+1] > nums[i+2]);

            if (strictlyIncreasing || strictlyDecreasing) {
                count++;
            }
        }
        return count;
    }
};