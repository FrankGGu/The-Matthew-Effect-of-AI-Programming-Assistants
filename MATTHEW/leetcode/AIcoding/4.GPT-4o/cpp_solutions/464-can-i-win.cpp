class Solution {
public:
    bool canIWin(int maxChoose, int desiredTotal) {
        if (desiredTotal <= 0) return true;
        if (maxChoose * (maxChoose + 1) / 2 < desiredTotal) return false;

        vector<bool> dp(desiredTotal + 1, false);
        vector<bool> visited(desiredTotal + 1, false);

        return canWin(maxChoose, desiredTotal, 0, dp, visited);
    }

    bool canWin(int maxChoose, int desiredTotal, int currentTotal, vector<bool>& dp, vector<bool>& visited) {
        if (currentTotal >= desiredTotal) return false;
        if (visited[currentTotal]) return dp[currentTotal];
        visited[currentTotal] = true;

        for (int i = 1; i <= maxChoose; ++i) {
            if (!canWin(maxChoose, desiredTotal, currentTotal + i, dp, visited)) {
                dp[currentTotal] = true;
                return true;
            }
        }
        dp[currentTotal] = false;
        return false;
    }
};