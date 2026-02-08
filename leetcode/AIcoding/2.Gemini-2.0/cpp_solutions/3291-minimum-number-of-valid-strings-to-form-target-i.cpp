#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int minNumber(string target, vector<string>& word) {
        int n = target.size();
        int m = word.size();
        vector<int> dp(n + 1, n + 1);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < m; ++j) {
                int wordLen = word[j].size();
                if (wordLen <= i) {
                    string sub = target.substr(i - wordLen, wordLen);
                    if (sub == word[j]) {
                        dp[i] = min(dp[i], dp[i - wordLen] + 1);
                    }
                }
            }
        }

        return (dp[n] > n) ? -1 : dp[n];
    }
};