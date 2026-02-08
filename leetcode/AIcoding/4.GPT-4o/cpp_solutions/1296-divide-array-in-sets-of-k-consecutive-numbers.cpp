#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    bool canDivideIntoSets(std::vector<int>& nums, int k) {
        if (nums.size() % k != 0) return false;
        std::unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        std::sort(nums.begin(), nums.end());
        for (int num : nums) {
            if (count[num] > 0) {
                for (int i = 0; i < k; i++) {
                    if (count[num + i] == 0) return false;
                    count[num + i]--;
                }
            }
        }
        return true;
    }
};