#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int lastStoneWeightII(std::vector<int>& stones) {
        int totalWeight = std::accumulate(stones.begin(), stones.end(), 0);
        int target = totalWeight / 2;
        std::vector<int> dp(target + 1, 0);

        for (int stone : stones) {
            for (int j = target; j >= stone; --j) {
                dp[j] = std::max(dp[j], dp[j - stone] + stone);
            }
        }

        return totalWeight - 2 * dp[target];
    }
};