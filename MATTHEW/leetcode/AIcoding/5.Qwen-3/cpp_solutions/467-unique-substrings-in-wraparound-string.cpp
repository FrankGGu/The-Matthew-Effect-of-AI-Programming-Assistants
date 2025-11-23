#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int findSubstringInWrapup(const string& p) {
        vector<int> dp(26, 0);
        int count = 0;
        for (int i = 0; i < p.length(); ++i) {
            if (i > 0 && (p[i] - p[i-1] == 1 || p[i-1] - p[i] == 25)) {
                dp[p[i] - 'a'] = dp[p[i-1] - 'a'] + 1;
            } else {
                dp[p[i] - 'a'] = 1;
            }
            count += dp[p[i] - 'a'];
        }
        return count;
    }
};