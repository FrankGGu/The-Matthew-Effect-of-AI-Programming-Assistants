#include <vector>

using namespace std;

class Solution {
public:
    bool isPossibleToCutPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        if (m == 1 && n == 1) return false;

        vector<vector<int>> visited(m, vector<int>(n, 0));
        function<bool(int, int)> dfs = [&](int r, int c) {
            if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || visited[r][c] == 1) {
                return false;
            }
            visited[r][c] = 1;
            if (r == m - 1 && c == n - 1) {
                return true;
            }
            return dfs(r + 1, c) || dfs(r, c + 1);
        };

        if (!dfs(0, 0)) return true;

        vector<vector<int>> visited2(m, vector<int>(n, 0));
        grid[0][0] = 0;
        function<bool(int, int)> dfs2 = [&](int r, int c) {
            if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || visited2[r][c] == 1) {
                return false;
            }
            visited2[r][c] = 1;
            if (r == m - 1 && c == n - 1) {
                return true;
            }
            return dfs2(r + 1, c) || dfs2(r, c + 1);
        };

        bool reachable = dfs2(0,0);
        grid[0][0] = 1;
        return !reachable;
    }
};