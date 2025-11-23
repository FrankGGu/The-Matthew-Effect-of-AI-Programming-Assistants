#include <vector>

class Solution {
public:
    int countNegatives(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        int count = 0;
        int row = m - 1; 
        int col = 0;     

        while (row >= 0 && col < n) {
            if (grid[row][col] < 0) {
                count += (n - col);
                row--;
            } else {
                col++;
            }
        }

        return count;
    }
};