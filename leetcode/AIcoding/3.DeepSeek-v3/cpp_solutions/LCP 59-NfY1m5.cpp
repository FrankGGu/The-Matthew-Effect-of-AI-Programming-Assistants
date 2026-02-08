#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& stones) {
        int n = stones.size();
        if (n <= 1) return 0;

        vector<int> dp(n, INT_MAX);
        dp[0] = 0;
        dp[1] = abs(stones[1] - stones[0]);

        for (int i = 2; i < n; ++i) {
            dp[i] = min(dp[i-1] + abs(stones[i] - stones[i-1]), 
                        dp[i-2] + abs(stones[i] - stones[i-2]));
        }

        return dp[n-1];
    }
};