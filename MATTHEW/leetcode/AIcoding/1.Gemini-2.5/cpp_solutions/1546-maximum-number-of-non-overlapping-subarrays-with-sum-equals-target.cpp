#include <vector>
#include <unordered_set>

class Solution {
public:
    int maxNonOverlapping(std::vector<int>& nums, int target) {
        int count = 0;
        int current_sum = 0;
        std::unordered_set<int> seen_sums;
        seen_sums.insert(0);

        for (int num : nums) {
            current_sum += num;
            if (seen_sums.count(current_sum - target)) {
                count++;
                current_sum = 0;
                seen_sums.clear();
                seen_sums.insert(0);
            } else {
                seen_sums.insert(current_sum);
            }
        }

        return count;
    }
};