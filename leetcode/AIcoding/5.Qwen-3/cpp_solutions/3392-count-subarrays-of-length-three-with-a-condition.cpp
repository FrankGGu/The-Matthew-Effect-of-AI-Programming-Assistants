#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countOfSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i <= n - 3; ++i) {
            int maxVal = nums[i];
            int minVal = nums[i];
            for (int j = i + 1; j <= i + 2; ++j) {
                maxVal = max(maxVal, nums[j]);
                minVal = min(minVal, nums[j]);
            }
            if (maxVal - minVal <= k) {
                ++result;
            }
        }
        return result;
    }
};