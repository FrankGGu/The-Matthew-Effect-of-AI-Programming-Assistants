#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSubsequence(vector<int>& nums, int difference) {
        int n = nums.size();
        vector<int> dp(n, 1);
        int ans = 1;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] - nums[j] == difference) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
            ans = max(ans, dp[i]);
        }

        return ans;
    }
};