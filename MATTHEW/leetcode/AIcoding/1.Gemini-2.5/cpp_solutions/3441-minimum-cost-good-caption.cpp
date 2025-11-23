#include <vector>
#include <string>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minCostGoodCaption(std::vector<std::string>& words, std::vector<int>& costs, int minLen, int maxLen) {
        std::vector<int> dp(maxLen + 1, std::numeric_limits<int>::max());
        dp[0] = 0;

        for (int l = 1; l <= maxLen; ++l) {
            for (size_t i = 0; i < words.size(); ++i) {
                int wordLength = words[i].length();
                int wordCost = costs[i];

                if (l >= wordLength && dp[l - wordLength] != std::numeric_limits<int>::max()) {
                    dp[l] = std::min(dp[l], dp[l - wordLength] + wordCost);
                }
            }
        }

        int minTotalCost = std::numeric_limits<int>::max();
        for (int l = minLen; l <= maxLen; ++l) {
            minTotalCost = std::min(minTotalCost, dp[l]);
        }

        return (minTotalCost == std::numeric_limits<int>::max()) ? -1 : minTotalCost;
    }
};