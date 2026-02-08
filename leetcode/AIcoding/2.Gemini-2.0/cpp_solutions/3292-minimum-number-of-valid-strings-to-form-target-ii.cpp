#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minNumberOfStrings(string s, vector<string>& target) {
        int n = s.size();
        int m = target.size();
        vector<int> dp(n + 1, n + 1);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + 1;
            for (const string& t : target) {
                int k = t.size();
                if (i >= k && s.substr(i - k, k) == t) {
                    dp[i] = min(dp[i], dp[i - k]);
                }
            }
        }

        return dp[n];
    }
};