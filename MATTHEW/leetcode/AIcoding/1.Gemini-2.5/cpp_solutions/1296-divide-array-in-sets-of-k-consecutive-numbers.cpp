#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    bool isPossibleDivide(std::vector<int>& nums, int k) {
        if (nums.size() % k != 0) {
            return false;
        }

        std::map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        for (auto const& [start_num, count] : counts) {
            if (count > 0) {
                for (int i = 1; i < k; ++i) {
                    int current_num = start_num + i;
                    if (counts[current_num] < count) {
                        return false;
                    }
                    counts[current_num] -= count;
                }
            }
        }

        return true;
    }
};