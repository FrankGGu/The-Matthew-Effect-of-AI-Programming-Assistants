#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int monkeyMove(vector<int>& nums) {
        int n = nums.size();
        int mod = 1000000007;
        vector<int> dp(n, 0);
        dp[0] = 1;
        for (int i = 1; i < n; ++i) {
            dp[i] = (dp[i - 1] + dp[i - 1]) % mod;
        }
        return dp[n - 1];
    }
};