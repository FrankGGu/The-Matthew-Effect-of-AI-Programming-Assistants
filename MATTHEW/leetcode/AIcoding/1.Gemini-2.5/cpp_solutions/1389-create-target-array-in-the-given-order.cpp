#include <vector>
#include <numeric> // Not strictly needed for this problem, but often useful.

class Solution {
public:
    std::vector<int> createTargetArray(std::vector<int>& nums, std::vector<int>& index) {
        std::vector<int> target;
        for (int i = 0; i < nums.size(); ++i) {
            target.insert(target.begin() + index[i], nums[i]);
        }
        return target;
    }
};