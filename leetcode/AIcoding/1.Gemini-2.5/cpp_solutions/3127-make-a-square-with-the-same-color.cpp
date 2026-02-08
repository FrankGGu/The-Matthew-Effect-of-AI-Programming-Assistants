#include <vector>
#include <string>

class Solution {
public:
    bool canMakeSquare(std::vector<std::vector<char>>& grid) {
        for (int r = 0; r <= 1; ++r) {
            for (int c = 0; c <= 1; ++c) {
                int black_count = 0;
                int white_count = 0;

                if (grid[r][c] == 'B') black_count++; else white_count++;
                if (grid[r][c+1] == 'B') black_count++; else white_count++;
                if (grid[r+1][c] == 'B') black_count++; else white_count++;
                if (grid[r+1][c+1] == 'B') black_count++; else white_count++;

                if (black_count >= 3 || white_count >= 3) {
                    return true;
                }
            }
        }
        return false;
    }
};