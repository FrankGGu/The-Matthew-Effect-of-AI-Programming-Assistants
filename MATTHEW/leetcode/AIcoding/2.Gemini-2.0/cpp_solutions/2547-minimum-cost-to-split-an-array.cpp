#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                vector<int> freq(n, 0);
                int cost = k;
                for (int l = i - 1; l >= i - j; --l) {
                    freq[nums[l]]++;
                    if (freq[nums[l]] > 1) {
                        cost++;
                    }
                }
                dp[i] = min(dp[i], dp[i - j] + cost);
            }
        }

        return dp[n];
    }
};