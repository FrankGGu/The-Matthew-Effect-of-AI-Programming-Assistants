#include <vector>
#include <string>
#include <algorithm>

class Solution {
private:
    bool isSubsequence(const std::string& sub, const std::string& word) {
        int i = 0, j = 0;
        while (i < sub.length() && j < word.length()) {
            if (sub[i] == word[j]) {
                i++;
            }
            j++;
        }
        return i == sub.length();
    }

public:
    int minimumValidStrings(std::string target, std::vector<std::string>& words) {
        int n = target.length();

        std::vector<int> dp(n + 1, n + 1);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j] > n) {
                    continue;
                }
                std::string sub = target.substr(j, i - j);
                for (const std::string& w : words) {
                    if (isSubsequence(sub, w)) {
                        dp[i] = std::min(dp[i], dp[j] + 1);
                        break;
                    }
                }
            }
        }

        return dp[n] > n ? -1 : dp[n];
    }
};