#include <vector>

using namespace std;

class Solution {
public:
    vector<int> solve(int n, int m, vector<vector<int>>& grid, vector<pair<int, int>>& skips) {
        vector<int> result;
        int row = 0, col = 0, dir = 1; 
        vector<vector<bool>> visited(n, vector<bool>(m, false));

        while (result.size() < n * m) {
            if (!visited[row][col]) {
                result.push_back(grid[row][col]);
                visited[row][col] = true;
            }

            bool skipped = false;
            for (auto& skip : skips) {
                if (skip.first == row && skip.second == col) {
                    skipped = true;
                    break;
                }
            }

            if (skipped) {
                if (dir == 1) {
                    row++;
                    if (row >= n) {
                        row = n - 1;
                        col++;
                        dir = -1;
                    }
                    if (col >= m) {
                        col = m - 1;
                        row--;
                        dir = -1;
                    }
                } else {
                    row--;
                    if (row < 0) {
                        row = 0;
                        col++;
                        dir = 1;
                    }
                    if (col >= m) {
                        col = m - 1;
                        row++;
                        dir = 1;
                    }
                }
            } else {
                if (dir == 1) {
                    row--;
                    col++;
                    if (row < 0 && col < m) {
                        row = 0;
                        dir = -1;
                    } else if (col >= m && row >= 0) {
                        col = m - 1;
                        dir = -1;
                    } else if (row < 0 && col >= m) {
                        row = 1;
                        col = m - 1;
                        dir = -1;
                    }

                } else {
                    row++;
                    col--;
                    if (row >= n && col >= 0) {
                        row = n - 1;
                        dir = 1;
                    } else if (col < 0 && row < n) {
                        col = 0;
                        dir = 1;
                    } else if (row >= n && col < 0) {
                        row = n - 2;
                        col = 0;
                        dir = 1;
                    }
                }
            }
            if(row < 0) row = 0;
            if(col < 0) col = 0;
            if(row >= n) row = n - 1;
            if(col >= m) col = m - 1;
        }

        return result;
    }
};