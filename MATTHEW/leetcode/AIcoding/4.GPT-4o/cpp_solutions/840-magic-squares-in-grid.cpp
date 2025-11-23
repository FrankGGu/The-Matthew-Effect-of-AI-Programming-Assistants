class Solution {
public:
    int numMagicSquaresInside(vector<vector<int>>& grid) {
        int count = 0;
        for(int i = 0; i < grid.size() - 2; ++i) {
            for(int j = 0; j < grid[0].size() - 2; ++j) {
                if(isMagicSquare(grid, i, j)) {
                    count++;
                }
            }
        }
        return count;
    }

    bool isMagicSquare(vector<vector<int>>& grid, int row, int col) {
        set<int> uniqueNumbers;
        int sum = 0;
        for(int i = 0; i < 3; ++i) {
            for(int j = 0; j < 3; ++j) {
                uniqueNumbers.insert(grid[row + i][col + j]);
            }
        }
        if(uniqueNumbers.size() != 9 || uniqueNumbers.find(5) == uniqueNumbers.end()) {
            return false;
        }

        for(int i = 0; i < 3; ++i) {
            sum += grid[row][col + i];
        }
        for(int i = 1; i < 3; ++i) {
            sum += grid[row + i][col];
        }
        if(sum != 15) return false;

        sum = 0;
        for(int i = 0; i < 3; ++i) {
            sum += grid[row + i][col + i];
        }
        if(sum != 15) return false;

        sum = 0;
        for(int i = 0; i < 3; ++i) {
            sum += grid[row + i][col + (2 - i)];
        }
        if(sum != 15) return false;

        return true;
    }
};