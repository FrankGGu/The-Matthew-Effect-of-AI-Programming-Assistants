#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int numIdenticalPairs(std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        int pairs = 0;
        for (int num : nums) {
            pairs += count[num];
            count[num]++;
        }
        return pairs;
    }
};