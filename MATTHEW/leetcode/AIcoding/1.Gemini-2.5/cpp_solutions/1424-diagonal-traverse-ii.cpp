#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> findDiagonalOrder(std::vector<std::vector<int>>& nums) {
        std::vector<std::vector<int>> diagonals;

        for (int r = 0; r < nums.size(); ++r) {
            for (int c = 0; c < nums[r].size(); ++c) {
                int sum = r + c;
                if (sum >= diagonals.size()) {
                    diagonals.resize(sum + 1);
                }
                diagonals[sum].push_back(nums[r][c]);
            }
        }

        std::vector<int> result;
        for (int s = 0; s < diagonals.size(); ++s) {
            std::reverse(diagonals[s].begin(), diagonals[s].end());
            result.insert(result.end(), diagonals[s].begin(), diagonals[s].end());
        }

        return result;
    }
};