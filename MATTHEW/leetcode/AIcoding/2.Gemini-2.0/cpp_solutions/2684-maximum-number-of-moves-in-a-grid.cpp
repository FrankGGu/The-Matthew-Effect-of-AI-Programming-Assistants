#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxMoves(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));

        int max_moves = 0;
        for (int j = 0; j < n - 1; ++j) {
            for (int i = 0; i < m; ++i) {
                if (j == 0 || dp[i][j] > 0) {
                    if (i > 0 && grid[i - 1][j + 1] > grid[i][j]) {
                        dp[i - 1][j + 1] = max(dp[i - 1][j + 1], dp[i][j] + 1);
                        max_moves = max(max_moves, dp[i - 1][j + 1]);
                    }
                    if (grid[i][j + 1] > grid[i][j]) {
                        dp[i][j + 1] = max(dp[i][j + 1], dp[i][j] + 1);
                        max_moves = max(max_moves, dp[i][j + 1]);
                    }
                    if (i < m - 1 && grid[i + 1][j + 1] > grid[i][j]) {
                        dp[i + 1][j + 1] = max(dp[i + 1][j + 1], dp[i][j] + 1);
                        max_moves = max(max_moves, dp[i + 1][j + 1]);
                    }
                }
            }
            if(j == 0){
                for(int i = 0; i < m; i++){
                    if(dp[i][j+1] == 0 && grid[i][j+1] > grid[i][j]){
                        dp[i][j+1] = 1;
                        max_moves = max(max_moves, dp[i][j+1]);
                    }
                }
            }
        }

        return max_moves;
    }
};