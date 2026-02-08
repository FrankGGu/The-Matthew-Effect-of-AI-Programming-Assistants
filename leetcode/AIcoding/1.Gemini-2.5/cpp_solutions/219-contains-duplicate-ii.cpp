#include <vector>
#include <unordered_map>

class Solution {
public:
    bool containsNearbyDuplicate(std::vector<int>& nums, int k) {
        std::unordered_map<int, int> num_indices;
        for (int i = 0; i < nums.size(); ++i) {
            if (num_indices.count(nums[i])) {
                if (i - num_indices[nums[i]] <= k) {
                    return true;
                }
            }
            num_indices[nums[i]] = i;
        }
        return false;
    }
};