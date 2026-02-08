#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool canMakeSquare(const vector<vector<char>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i <= rows - 2; ++i) {
            for (int j = 0; j <= cols - 2; ++j) {
                unordered_set<char> colors;
                for (int x = 0; x < 2; ++x) {
                    for (int y = 0; y < 2; ++y) {
                        colors.insert(grid[i + x][j + y]);
                    }
                }
                if (colors.size() == 1) {
                    return true;
                }
            }
        }
        return false;
    }
};