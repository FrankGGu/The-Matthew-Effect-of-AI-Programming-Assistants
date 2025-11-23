#include <vector>

class Solution {
public:
    long long minIncrements(std::vector<int>& nums, int k) {
        long long totalIncrements = 0;
        for (int num : nums) {
            int remainder = num % k;
            if (remainder != 0) {
                totalIncrements += (k - remainder);
            }
        }
        return totalIncrements;
    }
};