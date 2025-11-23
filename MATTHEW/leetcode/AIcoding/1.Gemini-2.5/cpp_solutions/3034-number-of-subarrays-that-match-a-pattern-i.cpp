#include <vector>

class Solution {
public:
    int countMatchingSubarrays(std::vector<int>& nums, std::vector<int>& pattern) {
        int count = 0;
        int n = nums.size();
        int m = pattern.size();

        for (int i = 0; i <= n - (m + 1); ++i) {
            bool current_subarray_matches = true;
            for (int k = 0; k < m; ++k) {
                int val1 = nums[i + k];
                int val2 = nums[i + k + 1];

                if (pattern[k] == 0) {
                    if (val2 != val1) {
                        current_subarray_matches = false;
                        break;
                    }
                } else if (pattern[k] == 1) {
                    if (val2 <= val1) {
                        current_subarray_matches = false;
                        break;
                    }
                } else { // pattern[k] == -1
                    if (val2 >= val1) {
                        current_subarray_matches = false;
                        break;
                    }
                }
            }
            if (current_subarray_matches) {
                count++;
            }
        }
        return count;
    }
};