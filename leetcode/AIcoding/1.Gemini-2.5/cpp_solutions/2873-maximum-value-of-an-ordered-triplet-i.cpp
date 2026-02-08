#include <vector>
#include <algorithm>

class Solution {
public:
    long long maximumTripletValue(std::vector<int>& nums) {
        long long max_val = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    long long current_triplet_value = (long long)(nums[i] - nums[j]) * nums[k];
                    max_val = std::max(max_val, current_triplet_value);
                }
            }
        }
        return max_val;
    }
};