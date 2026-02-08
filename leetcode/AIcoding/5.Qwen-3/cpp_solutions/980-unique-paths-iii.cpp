#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int uniquePathsIII(vector<vector<int>>& grid) {
        int startRow = -1, startCol = -1;
        int emptyCells = 0;

        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[0].size(); ++j) {
                if (grid[i][j] == 1) {
                    startRow = i;
                    startCol = j;
                }
                if (grid[i][j] == 0) {
                    ++emptyCells;
                }
            }
        }

        int result = 0;
        vector<vector<bool>> visited(grid.size(), vector<bool>(grid[0].size(), false));
        dfs(grid, startRow, startCol, visited, emptyCells, result);
        return result;
    }

private:
    void dfs(vector<vector<int>>& grid, int row, int col, vector<vector<bool>>& visited, int emptyCells, int& result) {
        if (row < 0 || row >= grid.size() || col < 0 || col >= grid[0].size() || grid[row][col] == -1 || visited[row][col]) {
            return;
        }

        if (grid[row][col] == 2) {
            if (emptyCells == 0) {
                ++result;
            }
            return;
        }

        visited[row][col] = true;
        dfs(grid, row + 1, col, visited, emptyCells - 1, result);
        dfs(grid, row - 1, col, visited, emptyCells - 1, result);
        dfs(grid, row, col + 1, visited, emptyCells - 1, result);
        dfs(grid, row, col - 1, visited, emptyCells - 1, result);
        visited[row][col] = false;
    }
};