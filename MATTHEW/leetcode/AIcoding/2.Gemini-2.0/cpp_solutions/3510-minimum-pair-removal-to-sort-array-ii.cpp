#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumPairRemoval(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + 1;
            for (int j = 1; j < i; ++j) {
                if (nums[j - 1] <= nums[i - 1]) {
                    bool sorted = true;
                    for (int k = j; k < i - 1; ++k) {
                        if (nums[k] > nums[k + 1]) {
                            sorted = false;
                            break;
                        }
                    }
                    if (sorted) {
                        dp[i] = min(dp[i], dp[j - 1] + i - j - 1);
                    }
                }
            }
        }
        return dp[n];
    }
};