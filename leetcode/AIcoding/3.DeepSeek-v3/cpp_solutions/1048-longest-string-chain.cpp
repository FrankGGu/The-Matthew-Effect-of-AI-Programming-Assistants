
class Solution {
public:
    int longestStrChain(std::vector<std::string>& words) {
        std::sort(words.begin(), words.end(), [](const std::string& a, const std::string& b) {
            return a.size() < b.size();
        });

        std::unordered_map<std::string, int> dp;
        int maxChain = 0;

        for (const std::string& word : words) {
            int currentChain = 1;
            for (int i = 0; i < word.size(); ++i) {
                std::string predecessor = word.substr(0, i) + word.substr(i + 1);
                if (dp.find(predecessor) != dp.end()) {
                    currentChain = std::max(currentChain, dp[predecessor] + 1);
                }
            }
            dp[word] = currentChain;
            maxChain = std::max(maxChain, currentChain);
        }

        return maxChain;
    }
};