#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int dismantlingAction(string target) {
        int n = target.size();
        vector<int> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            dp[i] = i + 1; 
            for (int j = 1; j < i; ++j) {
                if (target[j - 1] == target[i - 1]) {
                    dp[i] = min(dp[i], dp[j] + i - j);
                }
            }
        }

        return dp[n];
    }
};