#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    long long minimalKSum(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        nums.erase(std::unique(nums.begin(), nums.end()), nums.end());

        long long current_k_limit = k;
        long long total_sum = current_k_limit * (current_k_limit + 1) / 2;

        for (int num : nums) {
            if (num > 0 && num <= current_k_limit) {
                total_sum -= num;
                current_k_limit++;
                total_sum += current_k_limit;
            }
        }

        return total_sum;
    }
};