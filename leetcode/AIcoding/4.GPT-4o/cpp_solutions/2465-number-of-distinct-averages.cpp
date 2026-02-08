#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    int distinctAverages(std::vector<int>& nums) {
        std::set<double> averages;
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        for (int i = 0; i < n / 2; ++i) {
            averages.insert((nums[i] + nums[n - 1 - i]) / 2.0);
        }
        return averages.size();
    }
};