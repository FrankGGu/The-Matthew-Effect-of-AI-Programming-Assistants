#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getBiggestThree(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        unordered_set<int> set;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                set.insert(grid[i][j]);
            }
        }

        for (int k = 1; k <= min(m, n) / 2; ++k) {
            for (int i = 0; i + 2 * k < m; ++i) {
                for (int j = 0; j + 2 * k < n; ++j) {
                    int sum = 0;
                    for (int d = 0; d <= k; ++d) {
                        sum += grid[i + d][j + k - d];
                        sum += grid[i + d][j + k + d];
                        sum += grid[i + 2 * k - d][j + k - d];
                        sum += grid[i + 2 * k - d][j + k + d];
                    }
                    sum -= grid[i + k][j];
                    sum -= grid[i + k][j + 2 * k];
                    set.insert(sum);
                }
            }
        }

        vector<int> res(set.begin(), set.end());
        sort(res.rbegin(), res.rend());
        return res.size() >= 3 ? vector<int>(res.begin(), res.begin() + 3) : res;
    }
};