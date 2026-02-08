#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int maximumNumberOfPairs(const std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        int pairs = 0;
        for (auto& [num, freq] : count) {
            pairs += freq / 2;
        }
        return pairs;
    }
};