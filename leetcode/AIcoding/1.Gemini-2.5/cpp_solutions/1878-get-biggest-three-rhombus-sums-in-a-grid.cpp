#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    std::vector<int> getBiggestThree(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        std::set<int> sums;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                sums.insert(grid[i][j]);

                for (int k = 1; ; ++k) {
                    if (i - k < 0 || i + k >= m || j - k < 0 || j + k >= n) {
                        break;
                    }

                    long long current_sum = 0;
                    int r = i - k;
                    int c = j;

                    for (int l = 0; l < k; ++l) {
                        current_sum += grid[r++][c++];
                    }
                    for (int l = 0; l < k; ++l) {
                        current_sum += grid[r++][c--];
                    }
                    for (int l = 0; l < k; ++l) {
                        current_sum += grid[r--][c--];
                    }
                    for (int l = 0; l < k; ++l) {
                        current_sum += grid[r--][c++];
                    }

                    sums.insert(current_sum);
                }
            }
        }

        std::vector<int> result;
        auto it = sums.rbegin();
        while (it != sums.rend() && result.size() < 3) {
            result.push_back(*it);
            ++it;
        }

        return result;
    }
};