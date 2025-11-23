#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    vector<int> getBiggestThree(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        set<int> sums;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                sums.insert(grid[i][j]);
                for (int k = 1; i - k >= 0 && i + k < m && j - k >= 0 && j + k < n; ++k) {
                    int sum = grid[i - k][j] + grid[i + k][j] + grid[i][j - k] + grid[i][j + k];
                    for (int l = 1; l < k; ++l) {
                        sum += grid[i - k + l][j - k + l];
                        sum += grid[i - k + l][j + k - l];
                        sum += grid[i + k - l][j - k + l];
                        sum += grid[i + k - l][j + k - l];
                    }
                    sums.insert(sum);
                }
            }
        }

        vector<int> result;
        for (auto it = sums.rbegin(); it != sums.rend(); ++it) {
            result.push_back(*it);
            if (result.size() == 3) {
                break;
            }
        }

        return result;
    }
};