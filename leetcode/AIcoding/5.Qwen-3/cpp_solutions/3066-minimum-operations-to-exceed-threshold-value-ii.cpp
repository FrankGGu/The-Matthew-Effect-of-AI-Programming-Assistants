#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        int operations = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] >= k) break;
            int needed = k - nums[i];
            if (needed > 0) {
                operations += needed;
                nums[i] += needed;
            }
        }
        return operations;
    }
};