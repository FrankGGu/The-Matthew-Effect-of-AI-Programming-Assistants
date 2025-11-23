#include <vector>
#include <set>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimumDifference(std::vector<int>& nums, int k) {
        int min_diff = INT_MAX;
        std::set<int> current_ors;

        for (int x : nums) {
            std::set<int> next_ors;

            next_ors.insert(x);

            for (int val : current_ors) {
                next_ors.insert(val | x);
            }

            for (int val : next_ors) {
                min_diff = std::min(min_diff, std::abs(val - k));
            }

            current_ors = next_ors;
        }

        return min_diff;
    }
};