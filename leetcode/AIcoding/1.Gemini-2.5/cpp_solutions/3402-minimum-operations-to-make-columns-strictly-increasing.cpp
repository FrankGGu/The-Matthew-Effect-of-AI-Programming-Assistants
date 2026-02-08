#include <vector>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) {
            return 0;
        }
        int n = grid[0].size();
        if (n == 0) {
            return 0;
        }

        int totalOperations = 0;

        for (int j = 0; j < n; ++j) {
            std::vector<int> columnElements;
            for (int i = 0; i < m; ++i) {
                columnElements.push_back(grid[i][j]);
            }

            int lisLength = lengthOfLIS_helper(columnElements);

            totalOperations += (m - lisLength);
        }

        return totalOperations;
    }

private:
    int lengthOfLIS_helper(const std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        std::vector<int> tails;
        for (int num : nums) {
            auto it = std::lower_bound(tails.begin(), tails.end(), num);
            if (it == tails.end()) {
                tails.push_back(num);
            } else {
                *it = num;
            }
        }
        return tails.size();
    }
};