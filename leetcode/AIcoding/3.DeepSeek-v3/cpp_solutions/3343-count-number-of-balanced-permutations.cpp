#include <vector>
using namespace std;

class Solution {
public:
    int countBalancedPermutations(int n) {
        if (n % 2 == 1) return 0;
        int m = n / 2;
        vector<long long> dp(m + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= m; ++i) {
            dp[i] = dp[i - 1] * (4 * i - 2) / (i + 1);
        }
        return dp[m];
    }
};