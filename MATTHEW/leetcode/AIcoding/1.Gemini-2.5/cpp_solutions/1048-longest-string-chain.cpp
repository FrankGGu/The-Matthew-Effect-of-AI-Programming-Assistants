#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    int longestStrChain(std::vector<std::string>& words) {
        std::sort(words.begin(), words.end(), [](const std::string& a, const std::string& b) {
            return a.length() < b.length();
        });

        std::unordered_map<std::string, int> dp;
        int max_len = 1;

        for (const std::string& word : words) {
            int current_max_chain = 1;
            for (int i = 0; i < word.length(); ++i) {
                std::string predecessor = word.substr(0, i) + word.substr(i + 1);
                if (dp.count(predecessor)) {
                    current_max_chain = std::max(current_max_chain, dp[predecessor] + 1);
                }
            }
            dp[word] = current_max_chain;
            max_len = std::max(max_len, current_max_chain);
        }

        return max_len;
    }
};