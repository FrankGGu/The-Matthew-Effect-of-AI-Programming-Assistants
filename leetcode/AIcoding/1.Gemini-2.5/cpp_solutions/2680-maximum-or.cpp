#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumOR(std::vector<int>& nums) {
        int n = nums.size();

        std::vector<int> prefix_or(n);
        std::vector<int> suffix_or(n);

        prefix_or[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            prefix_or[i] = prefix_or[i - 1] | nums[i];
        }

        suffix_or[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            suffix_or[i] = suffix_or[i + 1] | nums[i];
        }

        int max_or_val = 0;

        for (int i = 0; i < n; ++i) {
            int current_or = (nums[i] << 1); // Multiply nums[i] by 2

            if (i > 0) {
                current_or |= prefix_or[i - 1]; // OR with elements before nums[i]
            }
            if (i < n - 1) {
                current_or |= suffix_or[i + 1]; // OR with elements after nums[i]
            }
            max_or_val = std::max(max_or_val, current_or);
        }

        return max_or_val;
    }
};