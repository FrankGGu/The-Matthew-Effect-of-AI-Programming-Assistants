#include <vector>

class Solution {
public:
    int findSumOfArrayProductOfMagicalSequences(std::vector<int>& nums) {
        long long totalSum = 0;
        long long MOD = 1e9 + 7;

        for (int i = 0; i < nums.size(); ++i) {
            long long currentProduct = 1;
            for (int j = i; j < nums.size(); ++j) {
                currentProduct = (currentProduct * nums[j]);
                currentProduct = (currentProduct % MOD + MOD) % MOD;

                totalSum = (totalSum + currentProduct);
                totalSum = (totalSum % MOD + MOD) % MOD;
            }
        }
        return static_cast<int>(totalSum);
    }
};