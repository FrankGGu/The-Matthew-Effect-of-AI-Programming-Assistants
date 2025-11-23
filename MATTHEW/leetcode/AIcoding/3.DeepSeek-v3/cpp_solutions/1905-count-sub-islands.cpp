class Solution {
public:
    int countSubIslands(vector<vector<int>>& grid1, vector<vector<int>>& grid2) {
        int m = grid1.size();
        int n = grid1[0].size();
        int count = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid2[i][j] == 1) {
                    bool isSubIsland = true;
                    dfs(grid1, grid2, i, j, isSubIsland);
                    if (isSubIsland) {
                        ++count;
                    }
                }
            }
        }

        return count;
    }

private:
    void dfs(vector<vector<int>>& grid1, vector<vector<int>>& grid2, int i, int j, bool& isSubIsland) {
        int m = grid1.size();
        int n = grid1[0].size();

        if (i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] == 0) {
            return;
        }

        if (grid1[i][j] == 0) {
            isSubIsland = false;
        }

        grid2[i][j] = 0;

        dfs(grid1, grid2, i + 1, j, isSubIsland);
        dfs(grid1, grid2, i - 1, j, isSubIsland);
        dfs(grid1, grid2, i, j + 1, isSubIsland);
        dfs(grid1, grid2, i, j - 1, isSubIsland);
    }
};