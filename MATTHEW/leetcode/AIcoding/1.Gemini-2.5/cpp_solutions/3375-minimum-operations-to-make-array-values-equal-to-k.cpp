#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minOperations(std::vector<int>& nums, int k) {
        long long operations = 0;
        for (int num : nums) {
            if (num < k) {
                operations += (k - num);
            }
        }
        return operations;
    }
};