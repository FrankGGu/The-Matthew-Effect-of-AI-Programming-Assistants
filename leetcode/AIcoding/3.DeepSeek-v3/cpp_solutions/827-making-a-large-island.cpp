class Solution {
public:
    int largestIsland(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> areas(n * n + 2, 0);
        int index = 2;
        int max_area = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    areas[index] = dfs(grid, i, j, index);
                    max_area = max(max_area, areas[index]);
                    ++index;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    unordered_set<int> seen;
                    int area = 1;
                    for (int d = 0; d < 4; ++d) {
                        int ni = i + dirs[d][0];
                        int nj = j + dirs[d][1];
                        if (ni >= 0 && ni < n && nj >= 0 && nj < n && grid[ni][nj] > 1) {
                            int idx = grid[ni][nj];
                            if (seen.find(idx) == seen.end()) {
                                seen.insert(idx);
                                area += areas[idx];
                            }
                        }
                    }
                    max_area = max(max_area, area);
                }
            }
        }

        return max_area;
    }

private:
    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    int dfs(vector<vector<int>>& grid, int i, int j, int index) {
        int n = grid.size();
        if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] != 1) {
            return 0;
        }
        grid[i][j] = index;
        int area = 1;
        for (int d = 0; d < 4; ++d) {
            area += dfs(grid, i + dirs[d][0], j + dirs[d][1], index);
        }
        return area;
    }
};