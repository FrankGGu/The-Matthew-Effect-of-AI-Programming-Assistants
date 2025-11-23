#include <vector>
#include <numeric>
#include <algorithm>
#include <functional>

class Solution {
public:
    std::vector<int> minSubsequence(std::vector<int>& nums) {
        long long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        std::sort(nums.begin(), nums.end(), std::greater<int>());

        std::vector<int> result;
        long long currentSubsequenceSum = 0;

        for (int num : nums) {
            currentSubsequenceSum += num;
            result.push_back(num);
            if (currentSubsequenceSum > totalSum - currentSubsequenceSum) {
                break;
            }
        }

        return result;
    }
};