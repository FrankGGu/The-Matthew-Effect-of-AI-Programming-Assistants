#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTime(int n, vector<int>& a, vector<int>& t) {
        vector<int> dp(n, 0);
        for (int i = 0; i < n; ++i) {
            if (a[i] == 0) {
                dp[i] = 0;
            } else {
                dp[i] = t[i];
                if (i > 0) {
                    dp[i] += dp[i - 1];
                }
            }
        }
        return dp[n - 1];
    }
};