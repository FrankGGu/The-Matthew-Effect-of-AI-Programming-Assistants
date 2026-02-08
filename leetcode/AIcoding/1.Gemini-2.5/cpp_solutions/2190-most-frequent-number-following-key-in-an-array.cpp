#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int mostFrequent(std::vector<int>& nums, int key) {
        std::map<int, int> counts;
        int maxCount = 0;
        int result = 0;

        for (int i = 0; i < nums.size() - 1; ++i) {
            if (nums[i] == key) {
                int target = nums[i+1];
                counts[target]++;
                if (counts[target] > maxCount) {
                    maxCount = counts[target];
                    result = target;
                }
            }
        }
        return result;
    }
};