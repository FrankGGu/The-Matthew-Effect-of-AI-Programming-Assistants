class Solution {
public:
    int maximizeWin(vector<int>& prizePositions, int k) {
        int n = prizePositions.size();
        vector<int> dp(n + 1, 0);
        int res = 0;
        int left = 0;
        for (int right = 0; right < n; ++right) {
            while (prizePositions[right] - prizePositions[left] > k) {
                left++;
            }
            int current = right - left + 1;
            dp[right + 1] = max(dp[right], current);
            res = max(res, current + dp[left]);
        }
        return res;
    }
};