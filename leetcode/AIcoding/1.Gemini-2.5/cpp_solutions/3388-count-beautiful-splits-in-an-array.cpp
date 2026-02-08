#include <vector>
#include <numeric>

class Solution {
public:
    int beautifulSplits(std::vector<int>& nums) {
        int n = nums.size();

        std::vector<int> prefix_ones(n);
        std::vector<int> prefix_zeros(n);

        prefix_ones[0] = (nums[0] == 1 ? 1 : 0);
        prefix_zeros[0] = (nums[0] == 0 ? 1 : 0);

        for (int i = 1; i < n; ++i) {
            prefix_ones[i] = prefix_ones[i-1] + (nums[i] == 1 ? 1 : 0);
            prefix_zeros[i] = prefix_zeros[i-1] + (nums[i] == 0 ? 1 : 0);
        }

        int total_ones = prefix_ones[n-1];
        int total_zeros = prefix_zeros[n-1];

        int beautiful_count = 0;

        for (int k = 0; k < n - 1; ++k) {
            int ones_left = prefix_ones[k];
            int zeros_left = prefix_zeros[k];

            int ones_right = total_ones - ones_left;
            int zeros_right = total_zeros - zeros_left;

            if (ones_left == ones_right && zeros_left == zeros_right) {
                beautiful_count++;
            }
        }

        return beautiful_count;
    }
};