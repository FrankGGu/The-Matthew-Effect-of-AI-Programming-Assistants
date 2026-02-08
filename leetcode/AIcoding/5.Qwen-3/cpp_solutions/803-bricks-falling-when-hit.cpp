#include <vector>
#include <iostream>

using namespace std;

class Solution {
private:
    vector<vector<int>> dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    vector<vector<int>> grid;
    int rows, cols;

    bool isValid(int x, int y) {
        return x >= 0 && x < rows && y >= 0 && y < cols;
    }

    void dfs(int x, int y, vector<vector<int>>& visited) {
        if (!isValid(x, y) || visited[x][y] || grid[x][y] == 0) return;
        visited[x][y] = 1;
        for (auto& dir : dirs) {
            dfs(x + dir[0], y + dir[1], visited);
        }
    }

public:
    vector<int> hitBricks(vector<vector<int>>& grid) {
        this->grid = grid;
        rows = grid.size();
        cols = grid[0].size();
        vector<int> result(rows * cols, 0);
        int index = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    vector<vector<int>> visited(rows, vector<int>(cols, 0));
                    dfs(i, j, visited);
                    int count = 0;
                    for (int x = 0; x < rows; ++x) {
                        for (int y = 0; y < cols; ++y) {
                            if (visited[x][y]) count++;
                        }
                    }
                    result[index++] = count - 1;
                    grid[i][j] = 1;
                }
            }
        }

        return result;
    }
};