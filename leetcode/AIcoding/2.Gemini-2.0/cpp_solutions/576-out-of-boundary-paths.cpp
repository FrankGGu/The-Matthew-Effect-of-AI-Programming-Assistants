#include <vector>

using namespace std;

class Solution {
public:
    int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
        int mod = 1e9 + 7;
        vector<vector<int>> dp(m, vector<int>(n, 0));
        dp[startRow][startColumn] = 1;
        int count = 0;
        int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        for (int move = 0; move < maxMove; move++) {
            vector<vector<int>> temp(m, vector<int>(n, 0));
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (dp[i][j] > 0) {
                        for (auto& dir : directions) {
                            int newRow = i + dir[0];
                            int newCol = j + dir[1];

                            if (newRow < 0 || newRow >= m || newCol < 0 || newCol >= n) {
                                count = (count + dp[i][j]) % mod;
                            } else {
                                temp[newRow][newCol] = (temp[newRow][newCol] + dp[i][j]) % mod;
                            }
                        }
                    }
                }
            }
            dp = temp;
        }

        return count;
    }
};