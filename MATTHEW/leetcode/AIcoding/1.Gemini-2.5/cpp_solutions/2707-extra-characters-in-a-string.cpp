#include <string>
#include <vector>
#include <unordered_set>
#include <algorithm> // For std::min

class Solution {
public:
    int minExtraChar(std::string s, std::vector<std::string>& dictionary) {
        int n = s.length();
        std::unordered_set<std::string> dict_set(dictionary.begin(), dictionary.end());

        std::vector<int> dp(n + 1, n + 1); 
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i-1] + 1;

            for (int j = 0; j < i; ++j) {
                std::string current_word = s.substr(j, i - j);
                if (dict_set.count(current_word)) {
                    dp[i] = std::min(dp[i], dp[j]);
                }
            }
        }

        return dp[n];
    }
};