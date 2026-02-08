#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> findBall(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        std::vector<int> result(n);

        for (int start_col = 0; start_col < n; ++start_col) {
            int current_col = start_col;
            for (int r = 0; r < m; ++r) {
                int direction = grid[r][current_col]; // 1 for right, -1 for left
                int next_col = current_col + direction;

                // Check for boundary conditions and V-shape traps
                if (next_col < 0 || next_col >= n || grid[r][next_col] != direction) {
                    current_col = -1; // Ball got stuck
                    break;
                }
                current_col = next_col;
            }
            result[start_col] = current_col;
        }
        return result;
    }
};