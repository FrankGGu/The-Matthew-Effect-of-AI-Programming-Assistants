#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minStartValue(std::vector<int>& nums) {
        int min_prefix_sum = 0;
        int current_sum = 0;
        for (int num : nums) {
            current_sum += num;
            min_prefix_sum = std::min(min_prefix_sum, current_sum);
        }
        return 1 - min_prefix_sum;
    }
};