#include <vector>
#include <numeric>

class Solution {
public:
    int countPartitions(std::vector<int>& nums) {
        long long total_sum = 0;
        for (int num : nums) {
            total_sum += num;
        }

        if (total_sum % 2 != 0) {
            return 0;
        }

        long long n = nums.size();
        long long MOD = 1e9 + 7;

        long long result = 1;
        long long base = 2;
        long long power = n;

        while (power > 0) {
            if (power % 2 == 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            power /= 2;
        }

        return static_cast<int>(result);
    }
};