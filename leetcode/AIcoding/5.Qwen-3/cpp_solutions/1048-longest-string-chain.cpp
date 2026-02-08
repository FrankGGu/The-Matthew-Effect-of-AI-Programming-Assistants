#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestStrChain(vector<string>& words) {
        sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.size() < b.size();
        });

        vector<int> dp(words.size(), 1);
        int maxLen = 1;

        for (int i = 0; i < words.size(); ++i) {
            for (int j = 0; j < i; ++j) {
                if (words[i].size() == words[j].size() + 1 && isPredecessor(words[j], words[i])) {
                    dp[i] = max(dp[i], dp[j] + 1);
                    maxLen = max(maxLen, dp[i]);
                }
            }
        }

        return maxLen;
    }

private:
    bool isPredecessor(const string& pred, const string& word) {
        int i = 0, j = 0;
        while (i < pred.size() && j < word.size()) {
            if (pred[i] == word[j]) {
                ++i;
            }
            ++j;
        }
        return i == pred.size();
    }
};