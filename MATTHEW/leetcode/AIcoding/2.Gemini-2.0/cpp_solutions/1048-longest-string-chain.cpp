#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestStrChain(vector<string>& words) {
        sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.length() < b.length();
        });

        unordered_map<string, int> dp;
        int maxLen = 0;

        for (string word : words) {
            dp[word] = 1;
            for (int i = 0; i < word.length(); ++i) {
                string prevWord = word.substr(0, i) + word.substr(i + 1);
                if (dp.count(prevWord)) {
                    dp[word] = max(dp[word], dp[prevWord] + 1);
                }
            }
            maxLen = max(maxLen, dp[word]);
        }

        return maxLen;
    }
};