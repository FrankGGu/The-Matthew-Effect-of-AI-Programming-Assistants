class Solution {
public:
    int boxDelivering(vector<vector<int>>& boxes, int portsCount, int maxBoxes, int maxWeight) {
        int n = boxes.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;
        vector<int> prefixWeight(n + 1, 0);
        vector<int> prefixBoxes(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            prefixWeight[i] = prefixWeight[i - 1] + boxes[i - 1][1];
            prefixBoxes[i] = prefixBoxes[i - 1] + 1;
        }

        for (int i = 1; i <= n; ++i) {
            for (int j = i; j > 0; --j) {
                if (prefixBoxes[i] - prefixBoxes[j - 1] <= maxBoxes && 
                    prefixWeight[i] - prefixWeight[j - 1] <= maxWeight) {
                    dp[i] = min(dp[i], dp[j - 1] + 1);
                }
            }
        }

        return dp[n];
    }
};