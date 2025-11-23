#include <vector>
#include <algorithm>

class Solution {
public:
    int minMaxGame(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 1) {
            return nums[0];
        }

        while (n > 1) {
            std::vector<int> newNums(n / 2);
            for (int i = 0; i < n / 2; ++i) {
                if (i % 2 == 0) {
                    newNums[i] = std::min(nums[2 * i], nums[2 * i + 1]);
                } else {
                    newNums[i] = std::max(nums[2 * i], nums[2 * i + 1]);
                }
            }
            nums = newNums;
            n /= 2;
        }

        return nums[0];
    }
};