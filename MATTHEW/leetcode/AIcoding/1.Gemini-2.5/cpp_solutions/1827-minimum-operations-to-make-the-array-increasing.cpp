#include <vector>
#include <numeric>

class Solution {
public:
    long long minOperations(std::vector<int>& nums) {
        long long operations = 0;

        if (nums.size() < 2) {
            return 0;
        }

        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] <= nums[i-1]) {
                operations += (long long)nums[i-1] + 1 - nums[i];
                nums[i] = nums[i-1] + 1;
            }
        }

        return operations;
    }
};