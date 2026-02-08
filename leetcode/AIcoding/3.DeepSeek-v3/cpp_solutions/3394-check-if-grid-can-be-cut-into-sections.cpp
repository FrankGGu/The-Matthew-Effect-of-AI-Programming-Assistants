#include <vector>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    bool isPossibleToCutPath(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return false;
        int n = grid[0].size();
        if (n == 0) return false;

        if (!hasPath(grid, m, n)) {
            return true;
        }

        grid[0][0] = 1;
        if (!hasPath(grid, m, n)) {
            return true;
        }

        return false;
    }

private:
    bool hasPath(vector<vector<int>>& grid, int m, int n) {
        queue<pair<int, int>> q;
        q.push({0, 0});

        while (!q.empty()) {
            auto [i, j] = q.front();
            q.pop();

            if (i == m - 1 && j == n - 1) {
                return true;
            }

            if (i + 1 < m && grid[i + 1][j] == 1) {
                q.push({i + 1, j});
                if (i != 0 || j != 0) {
                    grid[i + 1][j] = 0;
                }
            }

            if (j + 1 < n && grid[i][j + 1] == 1) {
                q.push({i, j + 1});
                if (i != 0 || j != 0) {
                    grid[i][j + 1] = 0;
                }
            }
        }

        return false;
    }
};