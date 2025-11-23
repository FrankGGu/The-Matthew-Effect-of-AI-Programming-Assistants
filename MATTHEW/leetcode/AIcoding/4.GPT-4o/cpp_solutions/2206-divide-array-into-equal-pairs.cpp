#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    bool divideArray(std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        for (const auto& pair : count) {
            if (pair.second % 2 != 0) {
                return false;
            }
        }
        return true;
    }
};