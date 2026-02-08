#include <vector>

class Solution {
public:
    long long zeroFilledSubarrays(std::vector<int>& nums) {
        long long total_subarrays = 0;
        long long current_zero_count = 0;

        for (int num : nums) {
            if (num == 0) {
                current_zero_count++;
            } else {
                total_subarrays += (current_zero_count * (current_zero_count + 1)) / 2;
                current_zero_count = 0;
            }
        }

        total_subarrays += (current_zero_count * (current_zero_count + 1)) / 2;

        return total_subarrays;
    }
};