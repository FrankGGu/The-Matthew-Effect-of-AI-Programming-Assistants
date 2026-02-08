#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int stoneGameVII(vector<int>& stones) {
        int n = stones.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + stones[i];
        }

        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i + length - 1 < n; ++i) {
                int j = i + length - 1;
                dp[i][j] = max(stones[i] + (prefix[j + 1] - prefix[i + 1]) - dp[i + 1][j],
                               stones[j] + (prefix[j] - prefix[i]) - dp[i][j - 1]);
            }
        }

        return dp[0][n - 1];
    }
};