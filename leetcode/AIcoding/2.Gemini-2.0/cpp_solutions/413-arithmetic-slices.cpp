#include <vector>

using namespace std;

class Solution {
public:
    int numberOfArithmeticSlices(vector<int>& nums) {
        int n = nums.size();
        if (n < 3) return 0;

        int dp = 0;
        int sum = 0;
        for (int i = 2; i < n; ++i) {
            if (nums[i] - nums[i - 1] == nums[i - 1] - nums[i - 2]) {
                dp = dp + 1;
                sum += dp;
            } else {
                dp = 0;
            }
        }
        return sum;
    }
};