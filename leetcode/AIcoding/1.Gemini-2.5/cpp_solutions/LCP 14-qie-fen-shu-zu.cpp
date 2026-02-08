#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    bool check(long long max_sum_allowed, int k, const std::vector<int>& nums) {
        long long current_sum = 0;
        int num_subarrays = 1; 

        for (int num : nums) {
            if (num > max_sum_allowed) {
                return false; 
            }
            if (current_sum + num <= max_sum_allowed) {
                current_sum += num;
            } else {
                num_subarrays++;
                current_sum = num;
            }
        }
        return num_subarrays <= k;
    }

    int splitArray(std::vector<int>& nums, int k) {
        long long left = 0; 
        long long right = 0; 

        for (int num : nums) {
            left = std::max(left, (long long)num);
            right += num;
        }

        long long ans = right; 

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            if (check(mid, k, nums)) {
                ans = mid;
                right = mid - 1; 
            } else {
                left = mid + 1; 
            }
        }
        return (int)ans;
    }
};