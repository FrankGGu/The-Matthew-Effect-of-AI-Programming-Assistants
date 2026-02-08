#include <vector>
#include <numeric>

class Solution {
public:
    int numSubarrayBoundedMax(std::vector<int>& nums, int L, int R) {
        long long count_le_R = countSubarrays(nums, R);
        long long count_lt_L = countSubarrays(nums, L - 1);
        return static_cast<int>(count_le_R - count_lt_L);
    }

private:
    long long countSubarrays(const std::vector<int>& nums, int k) {
        long long ans = 0;
        long long current_length = 0;
        for (int num : nums) {
            if (num <= k) {
                current_length++;
            } else {
                ans += current_length * (current_length + 1) / 2;
                current_length = 0;
            }
        }
        ans += current_length * (current_length + 1) / 2;
        return ans;
    }
};