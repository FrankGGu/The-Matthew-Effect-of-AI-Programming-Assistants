#include <vector>
#include <algorithm> // For std::max and std::min

class Solution {
public:
    int sumOfBeauties(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 3) {
            return 0;
        }

        std::vector<int> leftMax(n);
        leftMax[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            leftMax[i] = std::max(leftMax[i - 1], nums[i]);
        }

        std::vector<int> rightMin(n);
        rightMin[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            rightMin[i] = std::min(rightMin[i + 1], nums[i]);
        }

        int totalBeauty = 0;
        for (int i = 1; i < n - 1; ++i) {
            if (nums[i] > leftMax[i - 1] && nums[i] < rightMin[i + 1]) {
                totalBeauty += 2;
            } else if (nums[i] > nums[i - 1] && nums[i] < nums[i + 1]) {
                totalBeauty += 1;
            }
        }

        return totalBeauty;
    }
};