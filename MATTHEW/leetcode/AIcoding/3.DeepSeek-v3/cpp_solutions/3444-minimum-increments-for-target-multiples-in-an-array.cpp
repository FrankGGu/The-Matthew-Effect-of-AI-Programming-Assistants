#include <vector>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int target) {
        std::sort(nums.begin(), nums.end());
        int operations = 0;
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum < target) {
            return -1;
        }

        int i = nums.size() - 1;
        while (target > 0) {
            int num = nums[i];
            if (num <= target) {
                target -= num;
                sum -= num;
            } else if (sum - num >= target) {
                sum -= num;
            } else {
                operations++;
                nums[i] /= 2;
                nums.push_back(nums[i]);
                std::sort(nums.begin(), nums.end());
                sum += nums[i];
                i = nums.size() - 1;
                continue;
            }
            i--;
            if (i < 0) {
                break;
            }
        }
        return operations;
    }
};