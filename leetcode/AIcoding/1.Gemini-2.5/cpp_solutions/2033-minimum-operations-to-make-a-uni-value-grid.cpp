#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int minOperations(std::vector<std::vector<int>>& grid, int x) {
        std::vector<int> flat_grid;
        for (const auto& row : grid) {
            for (int val : row) {
                flat_grid.push_back(val);
            }
        }

        int first_remainder = flat_grid[0] % x;
        for (size_t i = 1; i < flat_grid.size(); ++i) {
            if (flat_grid[i] % x != first_remainder) {
                return -1;
            }
        }

        std::sort(flat_grid.begin(), flat_grid.end());

        int n = flat_grid.size();
        int median_val = flat_grid[n / 2];

        long long operations = 0;
        for (int val : flat_grid) {
            operations += std::abs(val - median_val) / x;
        }

        return static_cast<int>(operations);
    }
};