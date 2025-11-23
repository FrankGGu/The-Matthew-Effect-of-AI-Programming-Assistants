#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minExtraChar(string s, vector<string>& dictionary) {
        int n = s.length();
        unordered_set<string> wordSet(dictionary.begin(), dictionary.end());
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + 1;
            for (int j = 1; j <= i; ++j) {
                if (wordSet.find(s.substr(i - j, j)) != wordSet.end()) {
                    dp[i] = min(dp[i], dp[i - j]);
                }
            }
        }

        return dp[n];
    }
};