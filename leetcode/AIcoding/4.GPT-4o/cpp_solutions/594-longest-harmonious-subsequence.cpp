#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int findLHS(std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int maxLength = 0;
        for (auto& [key, value] : count) {
            if (count.find(key + 1) != count.end()) {
                maxLength = std::max(maxLength, value + count[key + 1]);
            }
        }

        return maxLength;
    }
};