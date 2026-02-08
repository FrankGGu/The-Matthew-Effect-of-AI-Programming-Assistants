#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    long long maxRotateFunction(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        long long sum_all_elements = 0;
        long long current_F = 0;

        for (int i = 0; i < n; ++i) {
            sum_all_elements += nums[i];
            current_F += (long long)i * nums[i];
        }

        long long max_F = current_F;

        for (int i = 1; i < n; ++i) {
            current_F = current_F + sum_all_elements - (long long)n * nums[n - i];
            max_F = std::max(max_F, current_F);
        }

        return max_F;
    }
};