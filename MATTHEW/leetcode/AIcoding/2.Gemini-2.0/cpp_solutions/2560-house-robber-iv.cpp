#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canRob(vector<int>& nums, int k, int max_rob) {
        int count = 0;
        int n = nums.size();
        vector<int> dp(n, 0);

        if (n == 0) return true;

        if (nums[0] <= max_rob) {
            dp[0] = 1;
            count++;
        }

        for (int i = 1; i < n; ++i) {
            if (nums[i] <= max_rob) {
                if (i == 1) {
                    dp[i] = 1;
                } else {
                    dp[i] = (dp[i - 2] == 1 ? 1 : 0);
                    if(i >= 3 && dp[i-3] == 1 && dp[i-1] == 0)
                        dp[i] = 1;
                }
                if(dp[i] == 1)
                    count++;
            }
            else
                dp[i] = 0;

            if (i > 1 && dp[i] == 0 && dp[i-1] == 1)
                dp[i] = 0;
        }

        return count >= k;
    }

    int minCapability(vector<int>& nums, int k) {
        int left = 1;
        int right = *max_element(nums.begin(), nums.end());
        int ans = right;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canRob(nums, k, mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};