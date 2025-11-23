#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int findClosestNumber(std::vector<int>& nums) {
        int closestNum = nums[0];

        for (int num : nums) {
            int absNum = std::abs(num);
            int absClosestNum = std::abs(closestNum);

            if (absNum < absClosestNum) {
                closestNum = num;
            } else if (absNum == absClosestNum) {
                if (num > closestNum) {
                    closestNum = num;
                }
            }
        }

        return closestNum;
    }
};