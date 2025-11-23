#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> pacificAtlantic(int m, int n, vector<vector<int>>& matrix) {
        if (m == 0 || n == 0) return {};

        vector<vector<int>> result;
        vector<vector<bool>> pacific(m, vector<bool>(n, false));
        vector<vector<bool>> atlantic(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            dfs(matrix, i, 0, pacific);
            dfs(matrix, i, n-1, atlantic);
        }

        for (int j = 0; j < n; ++j) {
            dfs(matrix, 0, j, pacific);
            dfs(matrix, m-1, j, atlantic);
        }

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
    void dfs(vector<vector<int>>& matrix, int i, int j, vector<vector<bool>>& visited) {
        if (visited[i][j]) return;
        visited[i][j] = true;

        int dx[] = {-1, 1, 0, 0};
        int dy[] = {0, 0, -1, 1};

        for (int k = 0; k < 4; ++k) {
            int x = i + dx[k];
            int y = j + dy[k];

            if (x >= 0 && x < matrix.size() && y >= 0 && y < matrix[0].size() && matrix[x][y] >= matrix[i][j]) {
                dfs(matrix, x, y, visited);
            }
        }
    }
};