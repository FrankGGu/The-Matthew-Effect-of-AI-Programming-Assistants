#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumScore(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();

        int score1 = nums[n - 3] - nums[0];
        int score2 = nums[n - 1] - nums[2];
        int score3 = nums[n - 2] - nums[1];

        return std::min({score1, score2, score3});
    }
};