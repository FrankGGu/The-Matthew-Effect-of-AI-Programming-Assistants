#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums) {
        int total_increments = 0;
        int max_val = 0;

        for (int num : nums) {
            total_increments += __builtin_popcount(num);
            if (num > max_val) {
                max_val = num;
            }
        }

        if (max_val == 0) {
            return 0;
        }

        int max_doubles = 0;
        // For x > 0, floor(log2(x)) is equivalent to (number of bits in x) - 1
        // or (31 - __builtin_clz(x)) for a 32-bit unsigned int.
        // __builtin_clz(0) is undefined, so max_val > 0 check is crucial.
        max_doubles = 31 - __builtin_clz(static_cast<unsigned int>(max_val));

        return total_increments + max_doubles;
    }
};