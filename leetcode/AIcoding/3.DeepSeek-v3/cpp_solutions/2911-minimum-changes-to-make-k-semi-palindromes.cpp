class Solution {
public:
    int minimumChanges(string s, int k) {
        int n = s.size();
        vector<vector<int>> cost(n, vector<int>(n, 0));

        for (int l = 0; l < n; ++l) {
            for (int r = l + 1; r < n; ++r) {
                int len = r - l + 1;
                int minCost = INT_MAX;
                for (int d = 1; d < len; ++d) {
                    if (len % d != 0) continue;
                    int currCost = 0;
                    for (int i = 0; i < d; ++i) {
                        int left = l + i;
                        int right = r - (d - 1 - i);
                        while (left < right) {
                            if (s[left] != s[right]) currCost++;
                            left += d;
                            right -= d;
                        }
                    }
                    minCost = min(minCost, currCost);
                }
                cost[l][r] = minCost;
            }
        }

        vector<vector<int>> dp(k + 1, vector<int>(n + 1, INT_MAX / 2));
        dp[0][0] = 0;
        for (int i = 1; i <= k; ++i) {
            for (int j = 1; j <= n; ++j) {
                for (int p = 0; p < j; ++p) {
                    if (dp[i - 1][p] != INT_MAX / 2 && cost[p][j - 1] != INT_MAX) {
                        dp[i][j] = min(dp[i][j], dp[i - 1][p] + cost[p][j - 1]);
                    }
                }
            }
        }

        return dp[k][n];
    }
};