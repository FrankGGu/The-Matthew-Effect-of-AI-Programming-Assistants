#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSelectedElements(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<int> dp(n, 1);
        int res = 1;

        for (int i = 1; i < n; ++i) {
            if (nums[i] == nums[i-1] + 1) {
                dp[i] = dp[i-1] + 1;
            } else if (nums[i] == nums[i-1]) {
                dp[i] = dp[i-1];
            }
            res = max(res, dp[i]);
        }

        return res;
    }
};