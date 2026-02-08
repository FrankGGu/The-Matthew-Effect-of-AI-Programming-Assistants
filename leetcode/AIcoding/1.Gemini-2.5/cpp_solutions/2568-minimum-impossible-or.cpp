#include <vector>
#include <algorithm>

class Solution {
public:
    int minImpossibleOR(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        int current_max_formable_consecutive_OR = 0;

        for (int num : nums) {
            if (num > current_max_formable_consecutive_OR + 1) {
                return current_max_formable_consecutive_OR + 1;
            }
            current_max_formable_consecutive_OR |= num;
        }

        return current_max_formable_consecutive_OR + 1;
    }
};