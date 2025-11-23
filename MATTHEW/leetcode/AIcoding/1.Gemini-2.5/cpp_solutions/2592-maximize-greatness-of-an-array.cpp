#include <vector>
#include <algorithm>

class Solution {
public:
    int maximizeGreatness(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        int greatness = 0;
        int i = 0;

        for (int j = 0; j < nums.size(); ++j) {
            if (nums[i] < nums[j]) {
                greatness++;
                i++;
            }
        }

        return greatness;
    }
};