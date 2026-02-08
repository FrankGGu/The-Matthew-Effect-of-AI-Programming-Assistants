#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    int distinctAverages(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        std::set<double> averages;
        int left = 0;
        int right = nums.size() - 1;

        while (left < right) {
            double current_average = (static_cast<double>(nums[left]) + nums[right]) / 2.0;
            averages.insert(current_average);
            left++;
            right--;
        }

        return averages.size();
    }
};