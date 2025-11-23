#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int lastStoneWeightII(std::vector<int>& stones) {
        int totalSum = std::accumulate(stones.begin(), stones.end(), 0);

        int target = totalSum / 2;

        std::vector<bool> dp(target + 1, false);
        dp[0] = true;

        for (int stoneWeight : stones) {
            for (int j = target; j >= stoneWeight; --j) {
                dp[j] = dp[j] || dp[j - stoneWeight];
            }
        }

        int max_S1 = 0;
        for (int i = target; i >= 0; --i) {
            if (dp[i]) {
                max_S1 = i;
                break;
            }
        }

        return totalSum - 2 * max_S1;
    }
};