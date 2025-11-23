class Solution {
public:
    int minimumWhiteTiles(vector<int>& tiles, int carpetLen) {
        int n = tiles.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;
        int totalWhite = accumulate(tiles.begin(), tiles.end(), 0);

        for (int i = 0; i < n; i++) {
            dp[i + 1] = min(dp[i + 1], dp[i] + tiles[i]);
            int j = i - carpetLen + 1;
            if (j >= 0) {
                dp[i + 1] = min(dp[i + 1], dp[j] + (totalWhite - accumulate(tiles.begin() + j, tiles.begin() + i + 1, 0)));
            }
        }

        return dp[n];
    }
};