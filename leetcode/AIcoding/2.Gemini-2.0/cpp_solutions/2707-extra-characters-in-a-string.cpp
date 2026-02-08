#include <vector>
#include <string>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minExtraChar(string s, vector<string>& dictionary) {
        unordered_set<string> dict(dictionary.begin(), dictionary.end());
        int n = s.length();
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + 1;
            for (int j = 1; j <= i; ++j) {
                string sub = s.substr(i - j, j);
                if (dict.count(sub)) {
                    dp[i] = min(dp[i], dp[i - j]);
                }
            }
        }

        return dp[n];
    }
};