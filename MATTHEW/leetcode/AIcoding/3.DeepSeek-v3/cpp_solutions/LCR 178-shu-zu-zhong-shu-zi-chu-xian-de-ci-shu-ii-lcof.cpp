#include <vector>
using namespace std;

class Solution {
public:
    vector<int> trainingPlan(int n) {
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i & (i - 1)] + 1;
        }
        return dp;
    }
};