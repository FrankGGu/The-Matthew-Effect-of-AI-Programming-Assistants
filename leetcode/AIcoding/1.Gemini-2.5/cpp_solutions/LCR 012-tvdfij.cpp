#include <vector>
#include <numeric>

class Solution {
public:
    int pivotIndex(std::vector<int>& nums) {
        int totalSum = std::accumulate(nums.begin(), nums.end(), 0);
        int leftSum = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (leftSum == totalSum - leftSum - nums[i]) {
                return i;
            }
            leftSum += nums[i];
        }
        return -1;
    }
};