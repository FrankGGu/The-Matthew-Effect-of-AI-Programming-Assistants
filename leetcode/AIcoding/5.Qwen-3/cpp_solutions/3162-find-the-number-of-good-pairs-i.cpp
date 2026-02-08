#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int numIdenticalPairs(std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        int result = 0;
        for (int num : nums) {
            result += count[num];
            count[num]++;
        }
        return result;
    }
};