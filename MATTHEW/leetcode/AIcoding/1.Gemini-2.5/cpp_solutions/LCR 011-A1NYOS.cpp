#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int findMaxLength(std::vector<int>& nums) {
        std::unordered_map<int, int> sum_to_index;
        sum_to_index[0] = -1;
        int max_len = 0;
        int current_sum = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 0) {
                current_sum += -1;
            } else {
                current_sum += 1;
            }

            if (sum_to_index.count(current_sum)) {
                max_len = std::max(max_len, i - sum_to_index[current_sum]);
            } else {
                sum_to_index[current_sum] = i;
            }
        }

        return max_len;
    }
};