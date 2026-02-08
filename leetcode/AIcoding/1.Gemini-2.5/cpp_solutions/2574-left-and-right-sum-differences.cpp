#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    std::vector<int> leftRightDifference(std::vector<int>& nums) {
        int n = nums.size();
        long long rightSum = std::accumulate(nums.begin(), nums.end(), 0LL);
        long long leftSum = 0;
        std::vector<int> answer(n);

        for (int i = 0; i < n; ++i) {
            rightSum -= nums[i];
            answer[i] = std::abs(leftSum - rightSum);
            leftSum += nums[i];
        }

        return answer;
    }
};