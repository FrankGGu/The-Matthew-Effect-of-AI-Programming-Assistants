#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long findSumOfArrayProductOfMagicalSequences(int n, int m) {
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] * i;
        }
        long long result = 0;
        for (int i = 1; i <= n; ++i) {
            result += dp[i];
        }
        return result;
    }
};