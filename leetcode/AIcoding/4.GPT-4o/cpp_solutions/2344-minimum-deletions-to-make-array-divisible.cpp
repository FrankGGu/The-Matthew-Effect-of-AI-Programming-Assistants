#include <vector>
#include <algorithm>

class Solution {
public:
    int minDeletions(std::vector<int>& nums, std::vector<int>& numsDivide) {
        int g = numsDivide[0];
        for (int num : numsDivide) {
            g = std::gcd(g, num);
        }

        std::sort(nums.begin(), nums.end());
        int deletions = 0;

        for (int num : nums) {
            if (g % num == 0) {
                return deletions;
            }
            deletions++;
        }

        return -1;
    }
};