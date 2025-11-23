class Solution {
public:
    int countSubIslands(vector<vector<int>>& grid1, vector<vector<int>>& grid2) {
        int rows = grid1.size(), cols = grid1[0].size();
        int count = 0;

        function<void(int, int)> dfs = [&](int x, int y) {
            if (x < 0 || x >= rows || y < 0 || y >= cols || grid2[x][y] == 0) return;
            grid2[x][y] = 0;
            dfs(x + 1, y);
            dfs(x - 1, y);
            dfs(x, y + 1);
            dfs(x, y - 1);
        };

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid2[i][j] == 1) {
                    dfs(i, j);
                    bool isSubIsland = true;
                    for (int x = 0; x < rows; ++x) {
                        for (int y = 0; y < cols; ++y) {
                            if (grid2[x][y] == 0 && grid1[x][y] == 1) {
                                isSubIsland = false;
                                break;
                            }
                        }
                        if (!isSubIsland) break;
                    }
                    if (isSubIsland) count++;
                }
            }
        }

        return count;
    }
};