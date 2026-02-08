#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumTotalCost(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        long long dp_prev_pos = nums[0];
        long long dp_prev_neg = -nums[0];

        for (int i = 1; i < n; ++i) {
            long long current_pos = max(dp_prev_neg + nums[i], dp_prev_pos + nums[i]);
            long long current_neg = max(dp_prev_pos - nums[i], dp_prev_neg - nums[i]);

            dp_prev_pos = current_pos;
            dp_prev_neg = current_neg;
        }

        return max(dp_prev_pos, dp_prev_neg);
    }
};