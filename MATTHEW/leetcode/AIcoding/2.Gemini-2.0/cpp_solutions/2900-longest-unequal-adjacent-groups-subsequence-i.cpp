#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> getLongestSubsequence(vector<int>& groups, vector<int>& p) {
        int n = groups.size();
        int m = p.size();

        vector<int> dp(n, -1);
        dp[0] = -1;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (groups[j] == p[i]) {
                    if (j == 0 || (dp[j - 1] != -1 && dp[j - 1] < i)) {
                        dp[j] = i;
                    }
                }
            }
        }

        vector<int> result;
        int lastIndex = -1;
        for (int i = n - 1; i >= 0; --i) {
            if (dp[i] != -1 && (lastIndex == -1 || dp[i] < lastIndex)) {
                result.push_back(groups[i]);
                lastIndex = dp[i];
            }
        }

        reverse(result.begin(), result.end());
        return result;
    }
};