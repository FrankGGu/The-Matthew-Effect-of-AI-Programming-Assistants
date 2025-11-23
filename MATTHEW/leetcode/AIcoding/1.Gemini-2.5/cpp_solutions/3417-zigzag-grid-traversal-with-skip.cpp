#include <vector>

using namespace std;

class Solution {
public:
    vector<int> solve(int n, int m, vector<vector<int>>& grid, vector<vector<int>>& skip) {
        vector<int> result;
        int row = 0, col = 0;
        int dir = 1; 

        while (row >= 0 && row < n && col >= 0 && col < m) {
            result.push_back(grid[row][col]);

            bool skipped = false;
            for (const auto& s : skip) {
                if (s[0] == row && s[1] == col) {
                    row = s[2];
                    col = s[3];
                    skipped = true;
                    break;
                }
            }

            if (!skipped) {
                if (dir == 1) { 
                    if (row - 1 >= 0 && col + 1 < m) {
                        row--;
                        col++;
                    } else {
                        if (col + 1 < m) {
                            col++;
                            dir = -1;
                        } else {
                            row++;
                            dir = -1;
                        }
                    }
                } else { 
                    if (row + 1 < n && col - 1 >= 0) {
                        row++;
                        col--;
                    } else {
                        if (row + 1 < n) {
                            row++;
                            dir = 1;
                        } else {
                            col++;
                            dir = 1;
                        }
                    }
                }
            }
        }

        return result;
    }
};