#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minimumOperations(std::vector<int>& nums) {
        int n = nums.size();
        long long operations = 0;

        std::vector<long long> current_nums(n);
        for (int i = 0; i < n; ++i) {
            current_nums[i] = nums[i];
        }

        for (int i = 0; i < n; ++i) {
            if (current_nums[i] < 0) {
                return -1; 
            }
            if (current_nums[i] > 0) {
                operations += current_nums[i];
                if (i + 1 < n) {
                    current_nums[i+1] -= current_nums[i];
                } else {
                    return -1; 
                }
            }
        }

        return operations;
    }
};