#include <numeric>
#include <vector>

class Solution {
public:
    int subarrayGCD(std::vector<int>& nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int currentGCD = 0;
            for (int j = i; j < nums.size(); ++j) {
                currentGCD = std::gcd(currentGCD, nums[j]);
                if (currentGCD == k) {
                    count++;
                }
            }
        }
        return count;
    }
};