#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int findSubstringInWrapMultiMap(const string& s) {
        vector<int> dp(26, 0);
        int maxLen = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (i > 0 && (s[i] - s[i-1] == 1 || s[i-1] - s[i] == 25)) {
                dp[s[i] - 'a'] = dp[s[i-1] - 'a'] + 1;
            } else {
                dp[s[i] - 'a'] = 1;
            }
            maxLen = max(maxLen, dp[s[i] - 'a']);
        }
        return maxLen;
    }
};