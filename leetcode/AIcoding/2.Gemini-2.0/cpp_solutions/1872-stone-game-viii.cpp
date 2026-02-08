#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int stoneGameVIII(vector<int>& stones) {
        int n = stones.size();
        vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        vector<int> dp(n, 0);
        dp[n - 1] = prefixSum[n];

        for (int i = n - 2; i >= 1; --i) {
            dp[i] = max(prefixSum[i + 1] - dp[i + 1], dp[i + 1]);
        }

        return dp[1];
    }
};