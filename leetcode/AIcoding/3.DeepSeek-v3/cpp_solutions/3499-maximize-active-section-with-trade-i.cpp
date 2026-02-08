#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxActiveSections(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        vector<int> dp(n, 1);
        int max_len = 1;

        for (int i = 1; i < n; ++i) {
            if (nums[i] > nums[i-1]) {
                dp[i] = dp[i-1] + 1;
            } else {
                dp[i] = 1;
            }
            max_len = max(max_len, dp[i]);
        }

        return max_len;
    }
};