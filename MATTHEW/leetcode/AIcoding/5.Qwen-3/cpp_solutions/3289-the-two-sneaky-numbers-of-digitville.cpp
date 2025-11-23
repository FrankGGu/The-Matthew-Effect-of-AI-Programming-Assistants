#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<int> getSneakyNumbers(const std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        std::vector<int> result;
        for (int num : nums) {
            count[num]++;
        }
        for (const auto& pair : count) {
            if (pair.second == 2) {
                result.push_back(pair.first);
            }
        }
        return result;
    }
};