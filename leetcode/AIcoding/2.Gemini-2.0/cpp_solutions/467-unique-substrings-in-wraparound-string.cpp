#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findSubstringInWraproundString(string p) {
        int n = p.length();
        vector<int> dp(26, 0);
        int len = 0;
        for (int i = 0; i < n; ++i) {
            if (i > 0 && (p[i] - p[i - 1] == 1 || (p[i - 1] - p[i] == 25))) {
                len++;
            } else {
                len = 1;
            }
            dp[p[i] - 'a'] = max(dp[p[i] - 'a'], len);
        }
        int ans = 0;
        for (int i = 0; i < 26; ++i) {
            ans += dp[i];
        }
        return ans;
    }
};