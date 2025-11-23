#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int stoneGameVII(vector<int>& stones) {
        int n = stones.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                int sum = accumulate(stones.begin() + i, stones.begin() + j + 1, 0);
                dp[i][j] = max(sum - stones[i] - dp[i + 1][j], sum - stones[j] - dp[i][j - 1]);
            }
        }

        return dp[0][n - 1];
    }
};