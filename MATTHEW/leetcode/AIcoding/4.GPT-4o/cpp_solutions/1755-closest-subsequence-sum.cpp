#include <vector>
#include <numeric>
#include <unordered_set>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int minAbsDifference(std::vector<int>& nums, int goal) {
        int n = nums.size();
        int half = n / 2;
        std::vector<int> leftSums(1 << half), rightSums(1 << (n - half));

        for (int i = 0; i < (1 << half); ++i) {
            for (int j = 0; j < half; ++j) {
                if (i & (1 << j)) {
                    leftSums[i] += nums[j];
                }
            }
        }

        for (int i = 0; i < (1 << (n - half)); ++i) {
            for (int j = 0; j < n - half; ++j) {
                if (i & (1 << j)) {
                    rightSums[i] += nums[half + j];
                }
            }
        }

        std::unordered_set<int> leftSet(leftSums.begin(), leftSums.end());
        int result = std::abs(goal);

        for (int rightSum : rightSums) {
            for (int leftSum : leftSet) {
                int currentSum = leftSum + rightSum;
                result = std::min(result, std::abs(goal - currentSum));
                if (result == 0) return 0;
            }
        }

        return result;
    }
};