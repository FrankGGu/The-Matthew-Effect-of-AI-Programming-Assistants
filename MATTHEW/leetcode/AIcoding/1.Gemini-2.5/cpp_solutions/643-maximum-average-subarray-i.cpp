#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    double findMaxAverage(std::vector<int>& nums, int k) {
        long long current_sum = 0;
        for (int i = 0; i < k; ++i) {
            current_sum += nums[i];
        }

        long long max_sum = current_sum;

        for (int i = k; i < nums.size(); ++i) {
            current_sum += nums[i] - nums[i - k];
            if (current_sum > max_sum) {
                max_sum = current_sum;
            }
        }

        return static_cast<double>(max_sum) / k;
    }
};