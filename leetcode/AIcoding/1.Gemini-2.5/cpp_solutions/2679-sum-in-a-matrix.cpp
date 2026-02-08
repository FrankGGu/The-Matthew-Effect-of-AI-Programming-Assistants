#include <vector>
#include <algorithm>

class Solution {
public:
    int matrixSum(std::vector<std::vector<int>>& nums) {
        int m = nums.size();
        int n = nums[0].size();

        for (int i = 0; i < m; ++i) {
            std::sort(nums[i].begin(), nums[i].end());
        }

        int totalSum = 0;

        for (int j = 0; j < n; ++j) {
            int currentMaxAcrossRows = 0;
            for (int i = 0; i < m; ++i) {
                currentMaxAcrossRows = std::max(currentMaxAcrossRows, nums[i][n - 1 - j]);
            }
            totalSum += currentMaxAcrossRows;
        }

        return totalSum;
    }
};