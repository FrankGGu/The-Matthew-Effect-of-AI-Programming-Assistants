#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int numSquares(int n) {
        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;

        for (int i = 1; i * i <= n; ++i) {
            int square = i * i;
            for (int j = square; j <= n; ++j) {
                dp[j] = min(dp[j], dp[j - square] + 1);
            }
        }

        return dp[n];
    }
};