#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumWhiteTiles(string floor, int numCarpets, int carpetLen) {
        int n = floor.size();
        vector<vector<int>> dp(numCarpets + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= n; ++i) {
            dp[0][i] = dp[0][i - 1] + (floor[i - 1] == '1');
        }

        for (int i = 1; i <= numCarpets; ++i) {
            for (int j = 1; j <= n; ++j) {
                dp[i][j] = min(dp[i - 1][max(0, j - carpetLen)], dp[i][j - 1] + (floor[j - 1] == '1'));
            }
        }

        return dp[numCarpets][n];
    }
};