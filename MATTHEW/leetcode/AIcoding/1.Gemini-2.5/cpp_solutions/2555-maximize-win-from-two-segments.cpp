#include <vector>
#include <algorithm>

class Solution {
public:
    int maximizeWin(std::vector<int>& prizePositions, int k) {
        int n = prizePositions.size();
        if (n == 0) {
            return 0;
        }

        std::vector<int> dp(n + 1, 0);
        int ans = 0;
        int j = 0;
        for (int i = 0; i < n; ++i) {
            while (prizePositions[i] - prizePositions[j] > k) {
                j++;
            }

            dp[i + 1] = std::max(dp[i], i - j + 1);

            int right_count = i - j + 1;
            int left_prizes = dp[j];
            ans = std::max(ans, right_count + left_prizes);
        }

        return ans;
    }
};