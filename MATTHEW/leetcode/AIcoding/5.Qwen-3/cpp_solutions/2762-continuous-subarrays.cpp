#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>

class Solution {
public:
    int continuousSubarrays(std::vector<int>& nums) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int minVal = nums[i];
            int maxVal = nums[i];
            for (int j = i; j < n; ++j) {
                minVal = std::min(minVal, nums[j]);
                maxVal = std::max(maxVal, nums[j]);
                if (maxVal - minVal <= 2) {
                    result++;
                }
            }
        }
        return result;
    }
};