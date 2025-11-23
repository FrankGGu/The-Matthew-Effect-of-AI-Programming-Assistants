class Solution {
public:
    int minHeightShelves(vector<vector<int>>& books, int shelf_width) {
        int n = books.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            int width = 0;
            int height = 0;
            for (int j = i; j >= 1; --j) {
                width += books[j-1][0];
                if (width > shelf_width) break;
                height = max(height, books[j-1][1]);
                dp[i] = min(dp[i], dp[j-1] + height);
            }
        }

        return dp[n];
    }
};