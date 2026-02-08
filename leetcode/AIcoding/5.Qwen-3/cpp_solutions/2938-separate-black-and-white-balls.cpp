#include <iostream>
#include <vector>

class Solution {
public:
    int countBlackBlocks(std::vector<std::vector<int>>& pieces, int n) {
        std::vector<std::vector<int>> grid(n, std::vector<int>(n, 0));
        for (const auto& piece : pieces) {
            int x = piece[0];
            int y = piece[1];
            grid[x][y] = 1;
        }

        std::vector<std::vector<int>> blockCount(n, std::vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    if (i > 0 && j > 0) {
                        blockCount[i - 1][j - 1]++;
                    }
                    if (i > 0 && j < n - 1) {
                        blockCount[i - 1][j]++;
                    }
                    if (i < n - 1 && j > 0) {
                        blockCount[i][j - 1]++;
                    }
                    if (i < n - 1 && j < n - 1) {
                        blockCount[i][j]++;
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (blockCount[i][j] > 0) {
                    result++;
                }
            }
        }

        return result;
    }
};