class Solution {
public:
    int minimumDistance(string word) {
        int n = word.size();
        vector<vector<int>> dp(n + 1, vector<int>(n + 1, INT_MAX));
        dp[0][0] = 0;

        for (int i = 0; i <= n; ++i) {
            for (int j = 0; j <= n; ++j) {
                if (i < n) {
                    int pos1 = i == 0 ? 0 : word[i - 1] - 'A';
                    int pos2 = j == 0 ? 0 : word[j - 1] - 'A';
                    int dist = abs(pos1 - pos2) + abs(pos1 / 6 - pos2 / 6);
                    dp[i + 1][j] = min(dp[i + 1][j], dp[i][j] + dist);
                }
                if (j < n) {
                    int pos1 = i == 0 ? 0 : word[i - 1] - 'A';
                    int pos2 = j == 0 ? 0 : word[j - 1] - 'A';
                    int dist = abs(pos1 - pos2) + abs(pos1 / 6 - pos2 / 6);
                    dp[i][j + 1] = min(dp[i][j + 1], dp[i][j] + dist);
                }
            }
        }
        return dp[n][n];
    }
};