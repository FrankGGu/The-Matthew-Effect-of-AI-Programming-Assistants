#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfArithmeticSlices(vector<int>& nums) {
        int n = nums.size();
        int ans = 0;
        vector<unordered_map<long long, int>> dp(n);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                long long diff = (long long)nums[i] - nums[j];
                if (diff > INT_MAX || diff < INT_MIN) continue;

                if (dp[j].count(diff)) {
                    ans += dp[j][diff];
                    dp[i][diff] += dp[j][diff];
                }
                dp[i][diff]++;
            }
        }

        return ans;
    }
};