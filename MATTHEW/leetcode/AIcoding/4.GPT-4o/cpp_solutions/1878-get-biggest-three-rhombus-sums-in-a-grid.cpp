#include <vector>
#include <set>
using namespace std;

class Solution {
public:
    vector<int> getBiggestThree(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        set<int> sums;

        for (int r = 0; r < n; ++r) {
            for (int c = 0; c < m; ++c) {
                for (int d = 0; d < min(n, m); ++d) {
                    int sum = 0;
                    bool valid = true;
                    for (int i = 0; i <= d; ++i) {
                        if (r + i < n && c - i >= 0) sum += grid[r + i][c - i];
                        else { valid = false; break; }
                    }
                    for (int i = 1; i <= d; ++i) {
                        if (r + d - i < n && c + i < m) sum += grid[r + d - i][c + i];
                        else { valid = false; break; }
                    }
                    for (int i = 1; i <= d; ++i) {
                        if (r + d + i < n && c + i < m) sum += grid[r + d + i][c + i];
                        else { valid = false; break; }
                    }
                    for (int i = 1; i <= d; ++i) {
                        if (r + d - i < n && c - i >= 0) sum += grid[r + d - i][c - i];
                        else { valid = false; break; }
                    }
                    if (valid) sums.insert(sum);
                }
            }
        }

        vector<int> result;
        for (auto it = sums.rbegin(); it != sums.rend() && result.size() < 3; ++it) {
            result.push_back(*it);
        }

        return result;
    }
};