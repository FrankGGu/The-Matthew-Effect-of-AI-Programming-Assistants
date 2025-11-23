#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestUnequalAdjacentGroupsSubsequence(vector<string>& words, vector<int>& groups) {
        int n = words.size();
        vector<int> dp(n, 1);
        int ans = 1;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (groups[i] != groups[j]) {
                    bool unequal = true;
                    if (dp[i] < dp[j] + 1) {
                        dp[i] = dp[j] + 1;
                    }
                }
            }
            ans = max(ans, dp[i]);
        }

        return ans;
    }
};