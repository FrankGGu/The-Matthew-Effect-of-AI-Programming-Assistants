#include <vector>

class NeighborSum {
private:
    std::vector<std::vector<int>> grid;

public:
    NeighborSum(std::vector<std::vector<int>>& grid) {
        this->grid = grid;
    }

    void update(int row, int col, int val) {
        grid[row][col] = val;
    }

    int getSum(int row, int col) {
        int sum = 0;
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = row - 1; i <= row + 1; ++i) {
            for (int j = col - 1; j <= col + 1; ++j) {
                if (i >= 0 && i < rows && j >= 0 && j < cols) {
                    sum += grid[i][j];
                }
            }
        }

        return sum;
    }
};