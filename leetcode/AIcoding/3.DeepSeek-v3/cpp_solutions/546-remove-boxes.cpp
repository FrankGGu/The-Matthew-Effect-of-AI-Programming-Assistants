class Solution {
public:
    int removeBoxes(vector<int>& boxes) {
        int n = boxes.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n, 0)));
        return helper(boxes, 0, n - 1, 0, dp);
    }

    int helper(vector<int>& boxes, int i, int j, int k, vector<vector<vector<int>>>& dp) {
        if (i > j) return 0;
        if (dp[i][j][k] > 0) return dp[i][j][k];

        int res = (k + 1) * (k + 1) + helper(boxes, i + 1, j, 0, dp);

        for (int m = i + 1; m <= j; ++m) {
            if (boxes[i] == boxes[m]) {
                res = max(res, helper(boxes, i + 1, m - 1, 0, dp) + helper(boxes, m, j, k + 1, dp));
            }
        }

        dp[i][j][k] = res;
        return res;
    }
};