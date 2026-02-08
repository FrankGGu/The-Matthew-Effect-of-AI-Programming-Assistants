#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int findShortestSubarray(std::vector<int>& nums) {
        std::unordered_map<int, int> first, last;
        int degree = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (first.find(nums[i]) == first.end()) {
                first[nums[i]] = i;
            }
            last[nums[i]] = i;
            degree = std::max(degree, ++count[nums[i]]);
        }

        int minLength = nums.size();
        for (const auto& entry : count) {
            if (entry.second == degree) {
                minLength = std::min(minLength, last[entry.first] - first[entry.first] + 1);
            }
        }

        return minLength;
    }
};