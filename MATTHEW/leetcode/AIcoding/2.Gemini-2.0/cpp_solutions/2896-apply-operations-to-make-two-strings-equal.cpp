#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(string s1, string s2, int x) {
        int n = s1.size();
        vector<int> diff_indices;
        for (int i = 0; i < n; ++i) {
            if (s1[i] != s2[i]) {
                diff_indices.push_back(i);
            }
        }

        int m = diff_indices.size();
        if (m % 2 != 0) {
            return -1;
        }

        if (m == 0) {
            return 0;
        }

        vector<int> dp(m + 1, 1e9);
        dp[0] = 0;

        for (int i = 1; i <= m; ++i) {
            dp[i] = dp[i - 1] + 1;
            if (i >= 2) {
                dp[i] = min(dp[i], dp[i - 2] + min(x, diff_indices[i - 1] - diff_indices[i - 2]));
            }
        }

        return dp[m];
    }
};