#include <vector>
#include <unordered_map>

class Solution {
public:
    int findPairs(std::vector<int>& nums, int k) {
        if (k < 0) return 0;
        std::unordered_map<int, int> numCount;
        int count = 0;

        for (int num : nums) {
            numCount[num]++;
        }

        for (const auto& [num, cnt] : numCount) {
            if (k == 0) {
                if (cnt > 1) count++;
            } else {
                if (numCount.count(num + k)) count++;
            }
        }

        return count;
    }
};