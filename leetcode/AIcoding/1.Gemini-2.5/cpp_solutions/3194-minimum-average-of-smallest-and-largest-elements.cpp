#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    double minimumAverage(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        double min_avg = std::numeric_limits<double>::max();
        int n = nums.size();

        for (int i = 0; i < n / 2; ++i) {
            double current_avg = (static_cast<double>(nums[i] + nums[n - 1 - i])) / 2.0;
            if (current_avg < min_avg) {
                min_avg = current_avg;
            }
        }

        return min_avg;
    }
};