#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<int> intersection(std::vector<std::vector<int>>& nums) {
        std::unordered_map<int, int> count;
        for (const auto& num : nums[0]) {
            count[num]++;
        }
        for (size_t i = 1; i < nums.size(); ++i) {
            std::unordered_map<int, int> temp;
            for (int num : nums[i]) {
                if (count.find(num) != count.end()) {
                    temp[num]++;
                }
            }
            count = temp;
        }
        std::vector<int> result;
        for (const auto& pair : count) {
            result.push_back(pair.first);
        }
        return result;
    }
};