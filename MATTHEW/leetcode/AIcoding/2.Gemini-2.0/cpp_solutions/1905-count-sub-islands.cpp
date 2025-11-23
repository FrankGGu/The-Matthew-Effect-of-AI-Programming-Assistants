#include <vector>

using namespace std;

class Solution {
public:
    int countSubIslands(vector<vector<int>>& grid1, vector<vector<int>>& grid2) {
        int m = grid1.size();
        int n = grid1[0].size();
        int count = 0;

        function<bool(int, int)> dfs = [&](int i, int j) {
            if (i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] == 0) {
                return true;
            }

            grid2[i][j] = 0;
            bool isSubIsland = grid1[i][j] == 1;

            isSubIsland &= dfs(i + 1, j);
            isSubIsland &= dfs(i - 1, j);
            isSubIsland &= dfs(i, j + 1);
            isSubIsland &= dfs(i, j - 1);

            return isSubIsland;
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid2[i][j] == 1) {
                    if (dfs(i, j)) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};