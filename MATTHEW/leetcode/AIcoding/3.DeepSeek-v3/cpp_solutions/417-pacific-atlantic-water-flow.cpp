class Solution {
public:
    vector<vector<int>> pacificAtlantic(vector<vector<int>>& heights) {
        if (heights.empty() || heights[0].empty()) return {};
        int m = heights.size(), n = heights[0].size();
        vector<vector<bool>> pacific(m, vector<bool>(n, false));
        vector<vector<bool>> atlantic(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            dfs(heights, pacific, i, 0, INT_MIN);
            dfs(heights, atlantic, i, n - 1, INT_MIN);
        }
        for (int j = 0; j < n; ++j) {
            dfs(heights, pacific, 0, j, INT_MIN);
            dfs(heights, atlantic, m - 1, j, INT_MIN);
        }

        vector<vector<int>> result;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (pacific[i][j] && atlantic[i][j]) {
                    result.push_back({i, j});
                }
            }
        }
        return result;
    }

private:
    void dfs(vector<vector<int>>& heights, vector<vector<bool>>& visited, int i, int j, int prev) {
        if (i < 0 || i >= heights.size() || j < 0 || j >= heights[0].size() || visited[i][j] || heights[i][j] < prev) {
            return;
        }
        visited[i][j] = true;
        dfs(heights, visited, i + 1, j, heights[i][j]);
        dfs(heights, visited, i - 1, j, heights[i][j]);
        dfs(heights, visited, i, j + 1, heights[i][j]);
        dfs(heights, visited, i, j - 1, heights[i][j]);
    }
};