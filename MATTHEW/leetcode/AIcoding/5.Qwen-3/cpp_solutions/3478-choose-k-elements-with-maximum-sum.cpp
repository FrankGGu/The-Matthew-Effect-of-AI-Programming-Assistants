#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumSum(int* nums, int numsSize, int k) {
        std::sort(nums, nums + numsSize, std::greater<int>());
        int sum = 0;
        for (int i = 0; i < k; ++i) {
            sum += nums[i];
        }
        return sum;
    }
};