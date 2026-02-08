#include <iostream>
#include <vector>
#include <set>

class Solution {
public:
    int distinctAverages(std::vector<int>& nums) {
        std::set<double> averages;
        int n = nums.size();
        for (int i = 0; i < n / 2; ++i) {
            double avg = (nums[i] + nums[n - 1 - i]) / 2.0;
            averages.insert(avg);
        }
        return averages.size();
    }
};