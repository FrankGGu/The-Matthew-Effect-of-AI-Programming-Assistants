class Solution {
public:
    int numMagicSquaresInside(vector<vector<int>>& grid) {
        int count = 0;
        int rows = grid.size();
        if (rows < 3) return 0;
        int cols = grid[0].size();
        if (cols < 3) return 0;

        for (int i = 0; i <= rows - 3; ++i) {
            for (int j = 0; j <= cols - 3; ++j) {
                if (isMagicSquare(grid, i, j)) {
                    count++;
                }
            }
        }

        return count;
    }

private:
    bool isMagicSquare(vector<vector<int>>& grid, int row, int col) {
        vector<int> nums(10, 0);
        for (int i = row; i < row + 3; ++i) {
            for (int j = col; j < col + 3; ++j) {
                int num = grid[i][j];
                if (num < 1 || num > 9 || nums[num] > 0) {
                    return false;
                }
                nums[num]++;
            }
        }

        int sum = grid[row][col] + grid[row][col + 1] + grid[row][col + 2];

        if (grid[row + 1][col] + grid[row + 1][col + 1] + grid[row + 1][col + 2] != sum) return false;
        if (grid[row + 2][col] + grid[row + 2][col + 1] + grid[row + 2][col + 2] != sum) return false;

        if (grid[row][col] + grid[row + 1][col] + grid[row + 2][col] != sum) return false;
        if (grid[row][col + 1] + grid[row + 1][col + 1] + grid[row + 2][col + 1] != sum) return false;
        if (grid[row][col + 2] + grid[row + 1][col + 2] + grid[row + 2][col + 2] != sum) return false;

        if (grid[row][col] + grid[row + 1][col + 1] + grid[row + 2][col + 2] != sum) return false;
        if (grid[row][col + 2] + grid[row + 1][col + 1] + grid[row + 2][col] != sum) return false;

        return true;
    }
};