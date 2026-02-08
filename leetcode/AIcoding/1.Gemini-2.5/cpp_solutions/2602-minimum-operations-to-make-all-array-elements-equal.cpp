#include <vector>
#include <algorithm>

class Solution {
public:
    long long minimumOperations(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        long long operations = 0;
        int level = 0;
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] > nums[i-1]) {
                level++;
            }
            operations += level;
        }
        return operations;
    }
};