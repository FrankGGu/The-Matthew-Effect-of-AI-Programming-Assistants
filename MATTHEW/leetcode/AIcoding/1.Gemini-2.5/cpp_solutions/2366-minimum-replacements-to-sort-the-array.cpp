#include <vector>
#include <cmath>

class Solution {
public:
    long long minimumReplacement(std::vector<int>& nums) {
        int n = nums.size();
        long long ans = 0;
        long long next_val = nums[n - 1];

        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] <= next_val) {
                next_val = nums[i];
                continue;
            }

            long long current_val = nums[i];
            long long num_parts = (current_val + next_val - 1) / next_val;

            ans += num_parts - 1;
            next_val = current_val / num_parts;
        }

        return ans;
    }
};