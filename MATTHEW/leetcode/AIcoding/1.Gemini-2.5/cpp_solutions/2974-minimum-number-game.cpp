#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> numberGame(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        std::vector<int> arr;
        for (int i = 0; i < nums.size(); i += 2) {
            arr.push_back(nums[i+1]);
            arr.push_back(nums[i]);
        }
        return arr;
    }
};