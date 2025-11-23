#include <vector>
#include <unordered_map>
#include <algorithm>
#include <limits>

class Solution {
public:
    int destroyTargets(std::vector<int>& nums, int space) {
        std::unordered_map<int, int> remainder_counts;
        for (int num : nums) {
            remainder_counts[num % space]++;
        }

        int max_destroyed_count = 0;
        int min_start_target = std::numeric_limits<int>::max();

        for (int num : nums) {
            int current_count = remainder_counts[num % space];
            if (current_count > max_destroyed_count) {
                max_destroyed_count = current_count;
                min_start_target = num;
            } else if (current_count == max_destroyed_count) {
                min_start_target = std::min(min_start_target, num);
            }
        }

        return min_start_target;
    }
};