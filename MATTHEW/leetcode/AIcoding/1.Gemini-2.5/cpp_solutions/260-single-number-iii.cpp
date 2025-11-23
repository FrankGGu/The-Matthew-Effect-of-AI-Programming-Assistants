#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> singleNumber(std::vector<int>& nums) {
        long long xor_all = 0;
        for (int num : nums) {
            xor_all ^= num;
        }

        long long rightmost_set_bit = xor_all & -xor_all;

        int num1 = 0;
        int num2 = 0;

        for (int num : nums) {
            if ((num & rightmost_set_bit) != 0) {
                num1 ^= num;
            } else {
                num2 ^= num;
            }
        }

        return {num1, num2};
    }
};