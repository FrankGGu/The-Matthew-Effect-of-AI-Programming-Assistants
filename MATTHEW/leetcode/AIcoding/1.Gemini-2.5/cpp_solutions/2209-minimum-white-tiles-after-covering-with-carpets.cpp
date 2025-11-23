#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minimumWhiteTiles(std::string tiles, int numCarpets, int carpetLen) {
        int n = tiles.length();

        std::vector<int> prefix_sum_white(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sum_white[i+1] = prefix_sum_white[i] + (tiles[i] == '1' ? 1 : 0);
        }

        int total_white_tiles = prefix_sum_white[n];

        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(numCarpets + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= numCarpets; ++j) {
                // Option 1: Do not use a carpet to cover the tile at index i-1.
                // The maximum covered tiles remain the same as for tiles[0...i-2] with j carpets.
                dp[i][j] = dp[i-1][j];

                // Option 2: Use a carpet ending at tile index i-1.
                // This carpet covers tiles from max(0, i - carpetLen) to i-1.
                // Calculate the number of white tiles covered by this specific carpet.
                int prev_idx = std::max(0, i - carpetLen);
                int covered_by_current_carpet = prefix_sum_white[i] - prefix_sum_white[prev_idx];

                // Add the white tiles covered by this carpet to the maximum tiles covered
                // before this carpet (i.e., dp[prev_idx][j-1]).
                dp[i][j] = std::max(dp[i][j], dp[prev_idx][j-1] + covered_by_current_carpet);
            }
        }

        // The problem asks for the minimum number of *uncovered* white tiles.
        // This is equal to the total number of white tiles minus the maximum number of
        // white tiles that can be covered using the given carpets.
        return total_white_tiles - dp[n][numCarpets];
    }
};