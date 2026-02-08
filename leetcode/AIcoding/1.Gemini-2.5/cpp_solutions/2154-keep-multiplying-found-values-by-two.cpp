#include <vector>
#include <unordered_set>

class Solution {
public:
    int findFinalValue(std::vector<int>& nums, int original) {
        std::unordered_set<int> num_set(nums.begin(), nums.end());
        while (num_set.count(original)) {
            original *= 2;
        }
        return original;
    }
};