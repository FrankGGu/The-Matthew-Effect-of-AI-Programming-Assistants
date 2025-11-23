#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    bool findTarget(std::vector<int>& nums, int k) {
        std::unordered_map<int, int> seen;
        for (int num : nums) {
            if (seen.find(k - num) != seen.end()) {
                return true;
            }
            seen[num] = 1;
        }
        return false;
    }
};