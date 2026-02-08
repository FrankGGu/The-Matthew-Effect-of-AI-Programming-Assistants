#include <iostream>
#include <vector>

class Solution {
public:
    int kDivisibleElementsSubarrays(const std::vector<int>& nums, int k) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = i; j < n; ++j) {
                if (nums[j] % k == 0) {
                    ++count;
                }
                if (count > 0) {
                    ++result;
                }
            }
        }
        return result;
    }
};