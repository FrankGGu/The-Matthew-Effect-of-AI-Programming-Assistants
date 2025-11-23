#include <string>
#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    bool wordBreak(std::string s, std::vector<std::string>& wordDict) {
        std::unordered_set<std::string> wordSet(wordDict.begin(), wordDict.end());
        int n = s.length();
        std::vector<bool> dp(n + 1, false);
        dp[0] = true;

        int max_len = 0;
        for (const auto& word : wordSet) {
            max_len = std::max(max_len, (int)word.length());
        }

        for (int i = 1; i <= n; ++i) {
            for (int j = i - 1; j >= std::max(0, i - max_len); --j) {
                if (dp[j] && wordSet.count(s.substr(j, i - j))) {
                    dp[i] = true;
                    break;
                }
            }
        }

        return dp[n];
    }
};