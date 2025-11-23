class Solution {
public:
    int removeBoxes(vector<int>& boxes) {
        int n = boxes.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n, 0)));

        function<int(int, int, int)> solve = [&](int l, int r, int k) {
            if (l > r) return 0;
            if (dp[l][r][k] != 0) return dp[l][r][k];

            while (r > l && boxes[r] == boxes[r - 1]) {
                r--;
                k++;
            }

            dp[l][r][k] = solve(l, r - 1, 0) + (k + 1) * (k + 1);
            for (int i = l; i < r; i++) {
                if (boxes[i] == boxes[r]) {
                    dp[l][r][k] = max(dp[l][r][k], solve(l, i, k + 1) + solve(i + 1, r - 1, 0));
                }
            }
            return dp[l][r][k];
        };

        return solve(0, n - 1, 0);
    }
};